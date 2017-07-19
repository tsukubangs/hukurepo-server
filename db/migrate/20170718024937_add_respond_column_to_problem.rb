class AddRespondColumnToProblem < ActiveRecord::Migration[5.0]
  def up
    add_column :problems, :responded, :boolean, default: false, null: false
  end

  def down
  end
end
