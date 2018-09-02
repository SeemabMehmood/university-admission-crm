class AddContactPersonDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :contact_person_name, :string, null: false, default: ""
    add_column :users, :contact_person_designation, :string, null: false, default: ""
    add_column :users, :contact_person_email, :string, null: false, default: ""
    add_column :users, :contact_person_mobile, :string, null: false, default: ""
    add_column :users, :contact_person_phone, :string
    add_column :users, :contact_person_skype, :string
  end
end
