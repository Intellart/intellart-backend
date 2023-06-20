class AddCurrentEditorToSections < ActiveRecord::Migration[7.0]
  def change
    add_reference :sections, :current_editor, foreign_key: { to_table: :users }
  end
end
