class AddRoleToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :role, :string, limit: 8, nil: false, default: 'user'
  end
end
