class AddJapaneseCommentColumnToProblem < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :japanese_comment, :text
  end
end
