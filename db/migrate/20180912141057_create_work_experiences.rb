class CreateWorkExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :work_experiences do |t|
      t.string :employer
      t.string :position
      t.string :period
      t.string :responsibilities
      t.string :scanned_doc
      t.integer :applicant_id, index: true, null: false

      t.timestamps
    end
  end
end
