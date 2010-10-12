class AddGenderToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :integer, :default => -1
    add_column :users, :organization, :string
  end

  def self.down
    remove_column :users, :organization
    remove_column :users, :gender
  end
end
