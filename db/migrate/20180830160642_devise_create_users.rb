# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      # personal info

      t.string :name,    null: false, default: ""
      t.string :country, null: false, default: ""
      t.integer :phone_num
      t.string :zipcode
      t.string :website
      t.string :skypeId
      t.string :street
      t.string :city

      t.string :facebook
      t.string :twitter
      t.string :linkdIn
      t.string :google

      t.integer :status

      t.string :download_csv, null: false, default: "allowed"

      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.datetime :last_sign_in_at

      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end
end
