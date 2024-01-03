class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.decimal :amount, null: false
      t.date :deadline, null: false
      t.references :article, null: false, foreign_key: true
      t.timestamps
    end
  end
end
