require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many  :feeds, :order => "feeds.created_at DESC", :dependent => :destroy

  has_many  :posts, :order => "posts.created_at DESC", :dependent => :nullify
  has_many  :comments, :order => "comments.created_at DESC", :dependent => :nullify
  has_many  :assets, :dependent => :nullify

  GENDER_MAN            = -1
  GENDER_WOMEN          = 1 #It has more sens isnt'it ?

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  validates_presence_of     :godfather_email
  validates_format_of       :godfather_email, :with => Authentication.email_regex, :message => "Error on godfather email"
  
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :godfather_email, :email_activation_code, :activation_code, :last_activity, :status, :organization, :posts_count, :comments_count
    
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.activate && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def godfather
    self.godfather_email
  end
  
  def godsons
    User.find(:all, :conditions => {:godfather_email => self.email})
  end
  
  def start_activation_process
    self.new_activation_code
    self.new_email_activation_code
    Delayed::Job.enqueue(DelayedJob::NotificationsNewAccount.new(self.id))
  end
  
  def activate_account
    unless self.activate then
      self.toggle!(:activate)
      Feed.create_user(self)
      Delayed::Job.enqueue(DelayedJob::NotifyAccountInfos.new(self.id))
    end
  end
  
  def reject_account
    Notifier.deliver_account_rejected(self)
  end
  
  def confirm_email
    self.update_attributes(:email_activation_code => nil)
    Notifier.deliver_account_infos(self)
  end
  
  def new_activation_code
    self.update_attributes(:activation_code => create_random_code) if self.activation_code.nil? 
  end
  
  def new_email_activation_code
    self.update_attributes(:email_activation_code => create_random_code) if self.email_activation_code.nil?
  end
  
  def gender_subject
    if self.gender == GENDER_MAN then
      "he"
    else
      "she"
    end
  end
  
  def gender_pronom
    if self.gender == GENDER_MAN then
      "his"
    else
      "her"
    end
  end
  
  def today_feeds
    _begin  = Time.now.strftime('%Y-%m-%d')
    _end    = Time.now.tomorrow.strftime('%Y-%m-%d')
    self.feeds_from(_begin, _end)
  end
  
  def feeds_from(date1, date2)
    self.feeds.find(:all, :conditions => "feeds.created_at >= '#{date1}' and feeds.created_at <= '#{date2}'")
  end
  
protected
  def create_random_code
    Digest::SHA1.hexdigest(Time.now.to_s)
  end
end
