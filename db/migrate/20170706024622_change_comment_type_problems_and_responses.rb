class ChangeCommentTypeProblemsAndResponses < ActiveRecord::Migration[5.0]
  def up
    change_column :problems, :comment, :text, default: nil
    change_column :responses, :comment, :text, default: nil
  end

  def down
    change_column :problems, :comment, :string
    change_column :responses, :comment, :string
  end
end
