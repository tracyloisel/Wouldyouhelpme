class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id      
      t.string  :email
      t.text    :content
      t.boolean :mail_me_comments, :default => true
      t.timestamps
    end
    
    add_index :posts, :user_id
  end

  def self.down
    drop_table :posts
  end
end
