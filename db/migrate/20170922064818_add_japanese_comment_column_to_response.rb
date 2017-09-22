class AddJapaneseCommentColumnToResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :japanese_comment, :text
  end
end
