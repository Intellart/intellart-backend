class CreateFieldsOfStudy < ActiveRecord::Migration[6.1]
  def change
    create_table :fields_of_studies do |t|
      t.string :field_name

      t.timestamps
    end
  end
end
