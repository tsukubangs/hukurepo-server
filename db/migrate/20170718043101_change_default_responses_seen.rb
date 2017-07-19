class ChangeDefaultResponsesSeen < ActiveRecord::Migration[5.0]
  def up
    change_column :problems, :responses_seen, :boolean, default: true, null: false
  end

  def down
    change_column :problems, :responses_seen, :boolean, default: true, null: false
  end
end
