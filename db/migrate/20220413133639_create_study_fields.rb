class CreateStudyFields < ActiveRecord::Migration[6.1]
  def change
    create_table :study_fields do |t|
      t.string :field_name

      t.timestamps
    end
  end
end
