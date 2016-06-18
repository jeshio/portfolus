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

ActiveRecord::Schema.define(version: 20160616114314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cities_on_country_id", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "email"
    t.string   "confirm_hash"
    t.boolean  "confirmed",    default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id"
    t.index ["confirm_hash"], name: "index_emails_on_confirm_hash", unique: true, using: :btree
    t.index ["email"], name: "index_emails_on_email", unique: true, using: :btree
    t.index ["user_id"], name: "index_emails_on_user_id", using: :btree
  end

  create_table "order_executer_requests", force: :cascade do |t|
    t.integer  "order_project_id"
    t.string   "comment"
    t.boolean  "by_customer"
    t.boolean  "confirmed"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "executer_id"
    t.integer  "price"
    t.index ["executer_id"], name: "index_order_executer_requests_on_executer_id", using: :btree
    t.index ["order_project_id"], name: "index_order_executer_requests_on_order_project_id", using: :btree
  end

  create_table "order_project_tags", force: :cascade do |t|
    t.integer "order_project_id"
    t.integer "tag_id"
    t.index ["order_project_id"], name: "index_order_project_tags_on_order_project_id", using: :btree
    t.index ["tag_id"], name: "index_order_project_tags_on_tag_id", using: :btree
  end

  create_table "order_project_technologies", force: :cascade do |t|
    t.integer "order_project_id"
    t.integer "technology_id"
    t.index ["order_project_id"], name: "index_order_project_technologies_on_order_project_id", using: :btree
    t.index ["technology_id"], name: "index_order_project_technologies_on_technology_id", using: :btree
  end

  create_table "order_projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price_min"
    t.integer  "price_max"
    t.boolean  "finished"
    t.integer  "views"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.integer  "executer_id"
    t.index ["category_id"], name: "index_order_projects_on_category_id", using: :btree
    t.index ["customer_id"], name: "index_order_projects_on_customer_id", using: :btree
    t.index ["executer_id"], name: "index_order_projects_on_executer_id", using: :btree
    t.index ["finished"], name: "index_order_projects_on_finished", using: :btree
    t.index ["price_max"], name: "index_order_projects_on_price_max", using: :btree
    t.index ["price_min"], name: "index_order_projects_on_price_min", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "url"
    t.string   "reg_hash"
    t.string   "admin_email"
    t.string   "domen"
    t.decimal  "views"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creater_id"
    t.index ["admin_email"], name: "index_organizations_on_admin_email", unique: true, using: :btree
    t.index ["creater_id"], name: "index_organizations_on_creater_id", using: :btree
    t.index ["domen"], name: "index_organizations_on_domen", unique: true, using: :btree
    t.index ["reg_hash"], name: "index_organizations_on_reg_hash", unique: true, using: :btree
    t.index ["url"], name: "index_organizations_on_url", unique: true, using: :btree
  end

  create_table "project_confirms", force: :cascade do |t|
    t.integer  "project_executer_id"
    t.string   "comment"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "confirmer_id"
    t.index ["confirmer_id"], name: "index_project_confirms_on_confirmer_id", using: :btree
    t.index ["project_executer_id"], name: "index_project_confirms_on_project_executer_id", using: :btree
  end

  create_table "project_executers", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "role"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.boolean  "executer_confirmed", default: false
    t.boolean  "creater_confirmed",  default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "executer_id"
    t.index ["executer_id"], name: "index_project_executers_on_executer_id", using: :btree
    t.index ["project_id"], name: "index_project_executers_on_project_id", using: :btree
  end

  create_table "project_tags", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "project_id"
    t.index ["project_id"], name: "index_project_tags_on_project_id", using: :btree
    t.index ["tag_id"], name: "index_project_tags_on_tag_id", using: :btree
  end

  create_table "project_technologies", force: :cascade do |t|
    t.integer "technology_id"
    t.integer "project_id"
    t.integer "power",         limit: 2
    t.index ["project_id"], name: "index_project_technologies_on_project_id", using: :btree
    t.index ["technology_id"], name: "index_project_technologies_on_technology_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "dev_finish_date"
    t.datetime "finish_date"
    t.decimal  "views"
    t.string   "version"
    t.integer  "category_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "client_id"
    t.integer  "creater_id"
    t.index ["category_id"], name: "index_projects_on_category_id", using: :btree
    t.index ["client_id"], name: "index_projects_on_client_id", using: :btree
    t.index ["creater_id"], name: "index_projects_on_creater_id", using: :btree
    t.index ["organization_id"], name: "index_projects_on_organization_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_technologies_on_name", unique: true, using: :btree
  end

  create_table "user_organizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_user_organizations_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_user_organizations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "family"
    t.string   "name"
    t.string   "middlename"
    t.integer  "city_id"
    t.integer  "views"
    t.integer  "created_projects_count",  default: 0
    t.integer  "executed_projects_count", default: 0
    t.index ["city_id"], name: "index_users_on_city_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "cities", "countries", on_delete: :nullify
  add_foreign_key "emails", "users"
  add_foreign_key "order_executer_requests", "order_projects"
  add_foreign_key "order_executer_requests", "users", column: "executer_id"
  add_foreign_key "order_project_tags", "order_projects"
  add_foreign_key "order_project_tags", "tags"
  add_foreign_key "order_project_technologies", "order_projects"
  add_foreign_key "order_project_technologies", "technologies"
  add_foreign_key "order_projects", "categories"
  add_foreign_key "order_projects", "users", column: "customer_id"
  add_foreign_key "order_projects", "users", column: "executer_id"
  add_foreign_key "organizations", "users", column: "creater_id"
  add_foreign_key "project_confirms", "project_executers"
  add_foreign_key "project_confirms", "users", column: "confirmer_id"
  add_foreign_key "project_executers", "projects"
  add_foreign_key "project_executers", "users", column: "executer_id"
  add_foreign_key "project_tags", "projects"
  add_foreign_key "project_tags", "tags"
  add_foreign_key "project_technologies", "projects"
  add_foreign_key "project_technologies", "technologies"
  add_foreign_key "projects", "categories"
  add_foreign_key "projects", "organizations"
  add_foreign_key "projects", "users", column: "client_id"
  add_foreign_key "projects", "users", column: "creater_id"
  add_foreign_key "user_organizations", "organizations"
  add_foreign_key "user_organizations", "users"
  add_foreign_key "users", "cities"
end
