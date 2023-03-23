class CreatePreprintComments < ActiveRecord::Migration[7.0]
  def change
    create_table :preprint_comments do |t|
      t.references :preprint, null: false, foreign_key: true
      t.references :commenter, foreign_key: { to_table: :users }
      t.references :reply_to, null: true, foreign_key: { to_table: :preprint_comments }
      t.text :comment

      t.timestamps
    end
  end
end
