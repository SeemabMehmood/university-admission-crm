class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :course_name, null: false, default: ""
      t.string :intake_month, null: false, default: ""
      t.string :intake_year, null: false, default: ""
      t.string :additional_document
      t.string :reference_no, null: false, default: ""

      t.references :representing_country, index: true
      t.references :representing_institution, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
