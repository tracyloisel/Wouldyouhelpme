class AddDownloadsCountToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :downloads_count, :integer, :default => 0
  end

  def self.down
    remove_column :assets, :downloads_count
  end
end
