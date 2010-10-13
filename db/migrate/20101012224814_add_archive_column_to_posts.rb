class AddArchiveColumnToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :archive, :boolean, :default => false
  end

  def self.down
    remove_column :posts, :archive
  end
end
