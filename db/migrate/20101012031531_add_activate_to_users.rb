class AddActivateToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :activate, :boolean, :default => false
    add_column :users, :activation_code, :string
    add_column :users, :email_activation_code, :string
    add_column :users, :new_email, :string
  end

  def self.down
    remove_column :users, :new_email
    remove_column :users, :email_activation_code
    remove_column :users, :activation_code
    remove_column :users, :activate
  end
end
