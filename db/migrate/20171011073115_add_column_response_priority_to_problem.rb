class AddColumnResponsePriorityToProblem < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :response_priority, :string, :after => :user_id, null: false, default: 'default'
  end
end
