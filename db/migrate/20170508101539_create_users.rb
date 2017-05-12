class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :age
      t.integer :gender
      t.string :nationality

      t.timestamps
    end
  end
end
