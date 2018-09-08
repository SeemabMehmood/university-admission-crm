class CreateRepresentingInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :representing_institutions do |t|
      t.string :name, null: false, default: ""
      t.string :campus
      t.string :contact_person, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :contact, null: false, default: ""
      t.string :website
      t.string :logo
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
