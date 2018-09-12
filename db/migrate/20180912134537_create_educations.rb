class CreateEducations < ActiveRecord::Migration[5.2]
  def change
    create_table :educations do |t|
      t.string :qualification
      t.string :institute
      t.string :year_passing
      t.string :grade
      t.string :scanned_doc
      t.integer :applicant_id, index: true, null: false

      t.timestamps
    end
  end
end
