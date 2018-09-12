class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :name
      t.string :designation
      t.string :institution
      t.string :fax
      t.string :address
      t.string :email
      t.string :phone
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.integer :applicant_id, index: true, null: false

      t.timestamps
    end
  end
end
