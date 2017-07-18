class ChangeNullProblem < ActiveRecord::Migration[5.0]
  def up
    change_column :problems, :comment, :text, default: "", null: false
    change_column :problems, :user_id, :integer, null: false
    change_column :problems, :responses_seen, :boolean, default: false, null: false
  end

  def down
    change_column :problems, :comment, :text
    change_column :problems, :user_id, :integer
    change_column :problems, :responses_seen, :boolean
  end
end
