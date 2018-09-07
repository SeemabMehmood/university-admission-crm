class CreateApplicationProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :application_processes do |t|
      t.string :name
      t.integer :serial
      t.integer :status, default: 0
      t.references :representing_country, index: true

      t.timestamps
    end
  end
end
