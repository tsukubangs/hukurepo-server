class AddColumnRoleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, :after => :email, null: false, default: 'poster'
  end
end
