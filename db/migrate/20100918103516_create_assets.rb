class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string  :filename, :content_type
      t.integer :size, :post_id, :user_id, :email
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
