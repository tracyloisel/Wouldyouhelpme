class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id, :user_id
      t.string  :email
      t.text    :content
      t.integer :usefulness, :default => 0
      t.timestamps
    end
    
    add_index :comments, [:post_id, :user_id]
  end

  def self.down
    drop_table :comments
  end
end
