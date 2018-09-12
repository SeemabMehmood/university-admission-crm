class CreateAdminNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_notes do |t|
      t.text :details
      t.integer :application_id, index: true, null: false

      t.timestamps
    end
  end
end
