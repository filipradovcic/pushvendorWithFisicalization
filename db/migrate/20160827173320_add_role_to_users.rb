class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string
  User.update(1,role: 'superadmin')
  end
end
