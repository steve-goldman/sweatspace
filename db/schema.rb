# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160126041829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_template_class_types", force: :cascade do |t|
    t.integer  "class_template_id"
    t.integer  "clazz_type_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "class_template_class_types", ["class_template_id"], name: "index_class_template_class_types_on_class_template_id", using: :btree
  add_index "class_template_class_types", ["clazz_type_id"], name: "index_class_template_class_types_on_clazz_type_id", using: :btree

  create_table "class_template_studios", force: :cascade do |t|
    t.integer  "class_template_id"
    t.integer  "studio_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "class_template_studios", ["class_template_id"], name: "index_class_template_studios_on_class_template_id", using: :btree
  add_index "class_template_studios", ["studio_id"], name: "index_class_template_studios_on_studio_id", using: :btree

  create_table "class_templates", force: :cascade do |t|
    t.integer  "studio_id"
    t.text     "description"
    t.integer  "duration"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.datetime "deleted_at"
  end

  add_index "class_templates", ["deleted_at"], name: "index_class_templates_on_deleted_at", using: :btree
  add_index "class_templates", ["studio_id"], name: "index_class_templates_on_studio_id", using: :btree

  create_table "clazz_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clazzs", force: :cascade do |t|
    t.datetime "timestamp"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "deleted_at"
    t.integer  "class_template_id"
    t.integer  "instructor_profile_id"
    t.integer  "studio_id"
    t.boolean  "confirmed"
    t.integer  "repeating_class_id"
    t.string   "date"
    t.string   "time_of_day"
  end

  add_index "clazzs", ["class_template_id"], name: "index_clazzs_on_class_template_id", using: :btree
  add_index "clazzs", ["confirmed"], name: "index_clazzs_on_confirmed", using: :btree
  add_index "clazzs", ["deleted_at"], name: "index_clazzs_on_deleted_at", using: :btree
  add_index "clazzs", ["instructor_profile_id"], name: "index_clazzs_on_instructor_profile_id", using: :btree
  add_index "clazzs", ["repeating_class_id"], name: "index_clazzs_on_repeating_class_id", using: :btree
  add_index "clazzs", ["studio_id"], name: "index_clazzs_on_studio_id", using: :btree
  add_index "clazzs", ["timestamp"], name: "index_clazzs_on_timestamp", using: :btree

  create_table "instructor_profiles", force: :cascade do |t|
    t.string   "profile_path"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.datetime "deleted_at"
  end

  add_index "instructor_profiles", ["deleted_at"], name: "index_instructor_profiles_on_deleted_at", using: :btree
  add_index "instructor_profiles", ["profile_path"], name: "index_instructor_profiles_on_profile_path", using: :btree
  add_index "instructor_profiles", ["user_id"], name: "index_instructor_profiles_on_user_id", using: :btree

  create_table "repeating_classes", force: :cascade do |t|
    t.integer  "class_template_id"
    t.integer  "studio_id"
    t.integer  "instructor_profile_id"
    t.boolean  "forever"
    t.date     "last_created_date"
    t.boolean  "confirmed"
    t.datetime "deleted_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "number_of_weeks"
    t.string   "time_of_day"
    t.integer  "day_of_week"
  end

  add_index "repeating_classes", ["class_template_id"], name: "index_repeating_classes_on_class_template_id", using: :btree
  add_index "repeating_classes", ["confirmed"], name: "index_repeating_classes_on_confirmed", using: :btree
  add_index "repeating_classes", ["deleted_at"], name: "index_repeating_classes_on_deleted_at", using: :btree
  add_index "repeating_classes", ["instructor_profile_id"], name: "index_repeating_classes_on_instructor_profile_id", using: :btree
  add_index "repeating_classes", ["studio_id"], name: "index_repeating_classes_on_studio_id", using: :btree

  create_table "studios", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "timezone"
    t.datetime "deleted_at"
  end

  add_index "studios", ["deleted_at"], name: "index_studios_on_deleted_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "deleted_at"
    t.boolean  "admin"
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "name"
    t.string   "image"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
