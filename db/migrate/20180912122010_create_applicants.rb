class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :title, null: false, default: ""
      t.string :gender, null: false, default: ""
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :dob, null: false, default: ""
      t.string :marital_status, null: false, default: ""
      t.string :nationality, null: false, default: ""
      t.boolean :passport
      t.string :passport_no
      t.string :phone_cc, null: false, default: ""
      t.string :phone_code, null: false, default: ""
      t.string :phone_num, null: false, default: ""
      t.string :mobile_cc
      t.string :mobile_code
      t.string :mobile_num
      t.string :email, null: false, default: ""
      t.string :skypeid
      t.integer :application_id, index: true, null: false

      t.timestamps
    end
  end
end
