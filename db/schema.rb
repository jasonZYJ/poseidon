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

ActiveRecord::Schema.define(version: 20160426174544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "state"
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.integer  "model_id"
    t.string   "model_type"
    t.integer  "context_id"
    t.string   "context_type"
    t.json     "model_info"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "agreements", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "brand_id"
    t.integer  "creator_id"
    t.integer  "responsible_person_id"
    t.integer  "first_party_id"
    t.integer  "second_party_id"
    t.decimal  "required_area"
    t.decimal  "expected_rent"
    t.string   "management_type"
    t.string   "expanding_region"
    t.string   "agreement_number"
    t.string   "state"
    t.integer  "opened_stores"
    t.integer  "expanding_stores"
    t.text     "renovation_standard"
    t.text     "payment_terms"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "context_id"
    t.string   "context_type"
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.string   "caption"
    t.integer  "attachment_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.string   "grade"
    t.integer  "sub_category_id"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "building_list_items", force: :cascade do |t|
    t.integer  "building_list_id"
    t.integer  "building_site_id"
    t.decimal  "portion",          precision: 19, scale: 4, default: 0.0
    t.decimal  "plot_ratio",       precision: 19, scale: 4, default: 0.0
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "building_lists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "building_sites", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "building_sites", ["category_id"], name: "index_building_sites_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.text     "body"
    t.boolean  "is_private"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "commissions", force: :cascade do |t|
    t.integer  "lease_id",   null: false
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "proportion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "full_name"
    t.string   "position"
    t.string   "email"
    t.string   "telephone"
    t.string   "mobile"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "contract_lists", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contract_lists", ["owner_id"], name: "index_contract_lists_on_owner_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.string   "name",                                                    null: false
    t.decimal  "unit_cost",        precision: 19, scale: 4, default: 0.0
    t.integer  "building_site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contracts", ["building_site_id"], name: "index_contracts_on_building_site_id", using: :btree

  create_table "document_counters", force: :cascade do |t|
    t.integer  "organisation_id"
    t.integer  "counter",         default: 0
    t.string   "document_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "investment_plans", force: :cascade do |t|
    t.integer  "real_estate_project_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "leases", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.text     "payment_terms"
    t.integer  "rent_free_days"
    t.decimal  "deposit"
    t.decimal  "quality_bond"
    t.decimal  "storage_space"
    t.decimal  "daily_rate"
    t.integer  "agreement_id",          null: false
    t.integer  "creator_id"
    t.integer  "responsible_person_id"
    t.integer  "first_party_id"
    t.integer  "second_party_id"
    t.integer  "shop_id"
    t.integer  "brand_id"
    t.integer  "workflow_id"
    t.integer  "parking"
    t.integer  "advertising_spot"
    t.string   "state"
    t.string   "lease_number"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "city"
    t.string   "province"
    t.string   "postcode"
    t.string   "telephone"
    t.string   "email"
    t.string   "address"
    t.string   "registered_address"
    t.string   "bank"
    t.string   "account"
    t.integer  "legal_representative_id"
    t.integer  "contact_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_installments", force: :cascade do |t|
    t.integer  "investment_plan_id"
    t.integer  "project_item_id"
    t.integer  "payment_month"
    t.decimal  "amount"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "role_id",                        null: false
    t.string   "resource_type",                  null: false
    t.boolean  "can_create",     default: false
    t.boolean  "can_read",       default: false
    t.boolean  "can_update",     default: false
    t.boolean  "can_delete",     default: false
    t.boolean  "can_transition", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "project_items", force: :cascade do |t|
    t.integer  "building_site_id",                                              null: false
    t.integer  "real_estate_project_id",                                        null: false
    t.decimal  "plot_ratio",             precision: 19, scale: 4, default: 0.0
    t.decimal  "floor_space",            precision: 19, scale: 4, default: 0.0
    t.decimal  "unit_price",             precision: 19, scale: 4, default: 0.0
    t.decimal  "total_cost",             precision: 19, scale: 4, default: 0.0
    t.decimal  "selling_price",          precision: 19, scale: 4, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "real_estate_projects", force: :cascade do |t|
    t.string   "location",                                                            null: false
    t.string   "infrastructure"
    t.decimal  "land_area",                    precision: 19, scale: 4, default: 0.0
    t.decimal  "land_transaction_fee",         precision: 19, scale: 4, default: 0.0
    t.decimal  "resettlement_compensation",    precision: 19, scale: 4, default: 0.0
    t.decimal  "land_acquisition_fee",         precision: 19, scale: 4, default: 0.0
    t.decimal  "plot_ratio",                   precision: 19, scale: 4, default: 0.0
    t.decimal  "green_field_ratio",            precision: 19, scale: 4, default: 0.0
    t.decimal  "building_density",             precision: 19, scale: 4, default: 0.0
    t.decimal  "building_setback_restriction", precision: 19, scale: 4, default: 0.0
    t.integer  "organisation_id"
    t.integer  "building_list_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "real_estate_projects", ["building_list_id"], name: "index_real_estate_projects_on_building_list_id", using: :btree
  add_index "real_estate_projects", ["organisation_id"], name: "index_real_estate_projects_on_organisation_id", using: :btree

  create_table "resource_types", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_imports", force: :cascade do |t|
    t.integer  "organisation_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "status"
  end

  create_table "shop_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_malls", force: :cascade do |t|
    t.text     "name"
    t.integer  "owner_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "building"
    t.string   "level"
    t.string   "number"
    t.text     "feature"
    t.text     "remark"
    t.integer  "type_id"
    t.integer  "sub_category_id"
    t.integer  "organisation_id"
    t.integer  "parent_id"
    t.integer  "workflow_id"
    t.decimal  "bay",             default: 0.0
    t.decimal  "depth",           default: 0.0
    t.decimal  "max_height",      default: 0.0
    t.decimal  "min_height",      default: 0.0
    t.decimal  "bearing",         default: 0.0
    t.decimal  "area",            default: 0.0
    t.boolean  "temporary",       default: false
    t.boolean  "is_deleted",      default: false
    t.integer  "children_count"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organisation_id"
    t.string   "name"
    t.string   "position"
    t.string   "phone"
    t.string   "mobile"
    t.boolean  "is_administrator",       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "visitations", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "contact_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.text     "remark"
    t.integer  "duration"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "workflow_logs", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "document_type"
    t.integer  "approver_id"
    t.integer  "membership_id"
    t.integer  "rank",          default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "workflow_rank_memberships", force: :cascade do |t|
    t.integer  "workflow_rank_id"
    t.integer  "role_id"
    t.boolean  "is_compulsory",    default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "workflow_ranks", force: :cascade do |t|
    t.integer  "workflow_id"
    t.integer  "rank",              default: 0
    t.integer  "minimum_approvers", default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "workflows", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "name"
    t.string   "resource_type"
    t.boolean  "is_default",    default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
