class AddCategoryIdToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :category, null: true, foreign_key: true
  end
end
