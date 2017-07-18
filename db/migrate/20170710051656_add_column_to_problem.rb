class AddColumnToProblem < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :responses_seen, :boolean
  end
end
