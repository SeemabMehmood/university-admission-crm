# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_12_141057) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "state"
    t.string "city", default: "", null: false
    t.string "address", default: "", null: false
    t.string "country", default: "", null: false
    t.string "area_code"
    t.boolean "permenant", default: true, null: false
    t.integer "applicant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_addresses_on_applicant_id"
  end

  create_table "applicants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "gender", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "dob", default: "", null: false
    t.string "marital_status", default: "", null: false
    t.string "nationality", default: "", null: false
    t.boolean "passport"
    t.string "passport_no"
    t.string "phone_cc", default: "", null: false
    t.string "phone_code", default: "", null: false
    t.string "phone_num", default: "", null: false
    t.string "mobile_cc"
    t.string "mobile_code"
    t.string "mobile_num"
    t.string "email", default: "", null: false
    t.string "skypeid"
    t.integer "application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_applicants_on_application_id"
  end

  create_table "application_processes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "serial"
    t.integer "status", default: 0
    t.bigint "representing_country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["representing_country_id"], name: "index_application_processes_on_representing_country_id"
  end

  create_table "applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "course_name", default: "", null: false
    t.string "intake_month", default: "", null: false
    t.string "intake_year", default: "", null: false
    t.string "additional_document"
    t.string "reference_no", default: "", null: false
    t.bigint "representing_country_id"
    t.bigint "representing_institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "counsellor_id", null: false
    t.index ["representing_country_id"], name: "index_applications_on_representing_country_id"
    t.index ["representing_institution_id"], name: "index_applications_on_representing_institution_id"
  end

  create_table "educations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "qualification"
    t.string "institute"
    t.string "year_passing"
    t.string "grade"
    t.string "scanned_doc"
    t.integer "applicant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_educations_on_applicant_id"
  end

  create_table "email_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.bigint "application_process_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_process_id"], name: "index_email_templates_on_application_process_id"
  end

  create_table "languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "listening"
    t.integer "speaking"
    t.integer "reading"
    t.integer "writing"
    t.integer "overall"
    t.string "type"
    t.string "scanned_doc"
    t.integer "applicant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_languages_on_applicant_id"
  end

  create_table "representing_countries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "agent_id", null: false
  end

  create_table "representing_institutions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "campus"
    t.string "contact_person", default: "", null: false
    t.string "email", default: "", null: false
    t.string "contact", default: "", null: false
    t.string "website"
    t.string "logo"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "counsellor_id"
    t.bigint "representing_country_id"
    t.integer "agent_id", null: false
    t.index ["counsellor_id"], name: "index_representing_institutions_on_counsellor_id"
    t.index ["representing_country_id"], name: "index_representing_institutions_on_representing_country_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "country", default: "", null: false
    t.string "phone_num"
    t.string "zipcode"
    t.string "website"
    t.string "skypeId"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "facebook"
    t.string "twitter"
    t.string "linkdIn"
    t.string "google"
    t.integer "status", default: 0
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "agent_id"
    t.integer "counsellor_id"
    t.integer "branch_officer_id"
    t.string "contact_person_name", default: "", null: false
    t.string "contact_person_designation", default: "", null: false
    t.string "contact_person_email", default: "", null: false
    t.string "contact_person_mobile", default: "", null: false
    t.string "contact_person_phone"
    t.string "contact_person_skype"
    t.string "logo"
    t.integer "download_csv", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_experiences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "employer"
    t.string "position"
    t.string "period"
    t.string "responsibilities"
    t.string "scanned_doc"
    t.integer "applicant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_work_experiences_on_applicant_id"
  end

  add_foreign_key "email_templates", "application_processes"
  add_foreign_key "representing_institutions", "representing_countries"
end
