class WelcomeController < ApplicationController
  layout 'layout'
  
  before_filter :login_required, :except => :index
  
  def index
  end
  
  def feeds
    @days_feeds = []
    @users      = User.find(:all, :conditions => "last_activity >= '#{7.days.ago.strftime('%Y-%m-%d')}'")
          
    7.times do |i|
      @users_feeds  = @users.collect{|user| {:user => user, :feeds => user.feeds_from(i.days.ago.strftime('%Y-%m-%d'), (i.days.ago + 1.day).strftime('%Y-%m-%d'))}}
      @users_feeds = @users_feeds.delete_if {|obj| obj[:feeds].empty?}
      
      @days_feeds << @users_feeds unless @users_feeds.empty?
    end
  end
end
