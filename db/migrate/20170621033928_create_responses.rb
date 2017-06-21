class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.string :response
      t.integer :problem_id
      t.integer :user_id
      t.timestamps
    end
  end
end
