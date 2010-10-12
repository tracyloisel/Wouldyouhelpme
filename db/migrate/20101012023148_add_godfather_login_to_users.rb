class AddGodfatherLoginToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :godfather_email, :string
  end

  def self.down
    remove_column :users, :godfather_email
  end
end
