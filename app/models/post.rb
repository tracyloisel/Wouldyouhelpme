class Post < ActiveRecord::Base
  acts_as_list
  
  belongs_to  :user, :counter_cache => true
  has_many    :comments, :dependent => :destroy, :order => "created_at DESC"
  has_many    :assets, :dependent => :destroy
end
