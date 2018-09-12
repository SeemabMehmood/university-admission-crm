class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :city, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :country, null: false, default: ""
      t.string :area_code
      t.boolean :permenant, null: false, default: true
      t.integer :applicant_id, index: true, null: false

      t.timestamps
    end
  end
end
