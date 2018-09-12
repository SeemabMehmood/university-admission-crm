class CreateApplicationHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :application_histories do |t|
      t.string :status
      t.text :note
      t.string :document
      t.integer :application_id, index: true, null: false

      t.timestamps
    end
  end
end
