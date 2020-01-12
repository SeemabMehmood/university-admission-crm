class CreateApplicationInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :application_institutions do |t|
      t.integer :application_id, null: false, index: true
      t.integer :representing_institution_id, null: false, index: true
      t.timestamps
    end
  end
end
