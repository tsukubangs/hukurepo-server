class ChangeNullProblem < ActiveRecord::Migration[5.0]
  def up
    change_column :problems, :user_id, :integer, null: false
  end

  def down
    change_column :problems, :user_id, :integer
  end
end
