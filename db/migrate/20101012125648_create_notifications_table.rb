class CreateNotificationsTable < ActiveRecord::Migration
  def self.up
    create_table :feeds, :force => true do |t|
      t.integer :user_id, :object_id, :kind
      t.string  :cache_content
      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
