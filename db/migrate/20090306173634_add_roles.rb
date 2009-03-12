class AddRoles < ActiveRecord::Migration
  def self.up
    Role.create(:name => 'admin')
    Role.create(:name => 'user')
  end

  def self.down
    Role.find_by_name('admin').destroy
    Role.find_by_name('user').destroy
  end
end
