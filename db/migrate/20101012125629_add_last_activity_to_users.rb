class AddLastActivityToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_activity, :datetime
    add_column :users, :posts_count, :integer, :default => 0
    add_column :users, :comments_count, :integer, :default => 0
    add_column :posts, :comments_count, :integer, :default => 0
    
    Post.all.each do |post|
      post.update_attributes :comments_count => post.comments.size
    end
  end

  def self.down
    remove_column :posts, :comments_count
    remove_column :users, :comments_count
    remove_column :users, :posts_count
    remove_column :users, :last_activity
  end
end
