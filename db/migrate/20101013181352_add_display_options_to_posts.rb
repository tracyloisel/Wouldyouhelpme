class AddDisplayOptionsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :display_comments, :boolean, :default => true
    add_column :posts, :display_message, :boolean, :default => false
    add_column :posts, :authorized_comments, :boolean, :default => true
    add_column :posts, :usefullness, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :usefullness
    remove_column :posts, :authorized_comments
    remove_column :posts, :display_message
    remove_column :posts, :display_comments
  end
end
