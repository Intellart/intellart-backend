class CreatePreprintUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :preprint_users do |t|
      t.references :preprint, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
