class Post < ActiveRecord::Base
  include Authentication
  
  acts_as_list
  
  belongs_to  :user, :counter_cache => true
  has_many    :comments, :dependent => :destroy, :order => "created_at DESC"
  has_many    :assets, :dependent => :destroy
  
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  def votes_to_fontsize
    2
  end
  
  def move_to_archive
    self.toggle!(:archive)
  end
  
  def self.count_archive
    self.count(:all, :conditions => "archive=1")
  end
end
