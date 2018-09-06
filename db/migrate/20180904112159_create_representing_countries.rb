class CreateRepresentingCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :representing_countries do |t|
      t.string :name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
