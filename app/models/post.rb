class Post < ActiveRecord::Base
  acts_as_list
  
  has_many  :comments, :dependent => :destroy, :order => "created_at DESC"
  has_many  :assets, :dependent => :destroy
end
