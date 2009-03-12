class AddUserChangedPassword < ActiveRecord::Migration
  def self.up
    add_column 'users', :crypted_changed_password,          :string, :limit => 40
  end

  def self.down
    remove_column :users, :crypted_changed_password
  end
end
