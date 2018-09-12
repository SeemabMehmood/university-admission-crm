class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.string :sender_name, null: false, default: ""
      t.string :sender_email, null: false, default: ""
      t.string :reciever_name, null: false, default: ""
      t.string :reciever_email, null: false, default: ""
      t.text :message
      t.string :attachment
      t.integer :application_id, index: true, null: false

      t.timestamps
    end
  end
end
