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

ActiveRecord::Schema.define(version: 20170923142220) do

  create_table "apex$_acl", id: :decimal, force: :cascade do |t|
    t.decimal "ws_app_id", null: false
    t.string "username", null: false
    t.string "priv", limit: 1, null: false
    t.date "created_on", null: false
    t.string "created_by", null: false
    t.date "updated_on"
    t.string "updated_by"
    t.index ["ws_app_id"], name: "apex$_acl_idx1"
  end

  create_table "apex$_ws_files", id: :decimal, force: :cascade do |t|
    t.decimal "ws_app_id", null: false
    t.decimal "data_grid_id"
    t.decimal "row_id"
    t.decimal "webpage_id"
    t.string "component_level", limit: 30
    t.string "name", null: false
    t.string "image_alias"
    t.string "image_attributes"
    t.binary "content"
    t.date "content_last_update"
    t.string "mime_type", null: false
    t.string "content_charset"
    t.string "content_filename", limit: 500
    t.string "description", limit: 4000
    t.date "created_on", null: false
    t.string "created_by", null: false
    t.date "updated_on"
    t.string "updated_by"
    t.index ["ws_app_id", "data_grid_id", "row_id"], name: "apex$_ws_files_idx1"
    t.index ["ws_app_id", "webpage_id"], name: "apex$_ws_files_idx2"
  end

  create_table "apex$_ws_history", id: false, force: :cascade do |t|
    t.decimal "row_id", null: false
    t.decimal "ws_app_id", null: false
    t.decimal "data_grid_id", null: false
    t.string "column_name"
    t.string "old_value", limit: 4000
    t.string "new_value", limit: 4000
    t.string "application_user_id"
    t.date "change_date"
    t.index ["ws_app_id", "data_grid_id", "row_id"], name: "apex$_ws_history_idx"
  end

  create_table "apex$_ws_links", id: :decimal, force: :cascade do |t|
    t.decimal "ws_app_id", null: false
    t.decimal "data_grid_id"
    t.decimal "row_id"
    t.decimal "webpage_id"
    t.string "component_level", limit: 30
    t.string "tags", limit: 4000
    t.string "show_on_homepage", limit: 1
    t.string "link_name", null: false
    t.string "url", limit: 4000, null: false
    t.string "link_description", limit: 4000
    t.decimal "display_sequence"
    t.date "created_on", null: false
    t.string "created_by", null: false
    t.date "updated_on"
    t.string "updated_by"
    t.index ["ws_app_id", "data_grid_id", "row_id"], name: "apex$_ws_links_idx1"
    t.index ["ws_app_id", "webpage_id"], name: "apex$_ws_links_idx2"
  end

  create_table "apex$_ws_notes", id: :decimal, force: :cascade do |t|
    t.decimal "ws_app_id", null: false
    t.decimal "data_grid_id"
    t.decimal "row_id"
    t.decimal "webpage_id"
    t.string "component_level", limit: 30
    t.text "content"
    t.date "created_on", null: false
    t.string "created_by", null: false
    t.date "updated_on"
    t.string "updated_by"
    t.index ["ws_app_id", "data_grid_id", "row_id"], name: "apex$_ws_notes_idx1"
    t.index ["ws_app_id", "webpage_id"], name: "apex$_ws_notes_idx2"
  end

  create_table "apex$_ws_rows", id: :decimal, force: :cascade do |t|
    t.decimal "ws_app_id", null: false
    t.decimal "data_grid_id", null: false
    t.string "unique_value"
    t.string "tags", limit: 4000
    t.decimal "parent_row_id"
    t.string "owner"
    t.string "geocode", limit: 512
    t.decimal "load_order"
    t.decimal "change_count"
    t.date "created_on", null: false
    t.string "created_by", null: false
    t.date "updated_on"
    t.string "updated_by"
    t.string "c001", limit: 4000
    t.string "c002", limit: 4000
    t.string "c003", limit: 4000
    t.string "c004", limit: 4000
    t.string "c005", limit: 4000
    t.string "c006", limit: 4000
    t.string "c007", limit: 4000
    t.string "c008", limit: 4000
    t.string "c009", limit: 4000
    t.string "c010", limit: 4000
    t.string "c011", limit: 4000
    t.string "c012", limit: 4000
    t.string "c013", limit: 4000
    t.string "c014", limit: 4000
    t.string "c015", limit: 4000
    t.string "c016", limit: 4000
    t.string "c017", limit: 4000
    t.string "c018", limit: 4000
    t.string "c019", limit: 4000
    t.string "c020", limit: 4000
    t.string "c021", limit: 4000
    t.string "c022", limit: 4000
    t.string "c023", limit: 4000
    t.string "c024", limit: 4000
    t.string "c025", limit: 4000
    t.string "c026", limit: 4000
    t.string "c027", limit: 4000
    t.string "c028", limit: 4000
    t.string "c029", limit: 4000
    t.string "c030", limit: 4000
    t.string "c031", limit: 4000
    t.string "c032", limit: 4000
    t.string "c033", limit: 4000
    t.string "c034", limit: 4000
    t.string "c035", limit: 4000
    t.string "c036", limit: 4000
    t.string "c037", limit: 4000
    t.string "c038", limit: 4000
    t.string "c039", limit: 4000
    t.string "c040", limit: 4000
    t.string "c041", limit: 4000
    t.string "c042", limit: 4000
    t.string "c043", limit: 4000
    t.string "c044", limit: 4000
    t.string "c045", limit: 4000
    t.string "c046", limit: 4000
    t.string "c047", limit: 4000
    t.string "c048", limit: 4000
    t.string "c049", limit: 4000
    t.string "c050", limit: 4000
    t.decimal "n001"
    t.decimal "n002"
    t.decimal "n003"
    t.decimal "n004"
    t.decimal "n005"
    t.decimal "n006"
    t.decimal "n007"
    t.decimal "n008"
    t.decimal "n009"
    t.decimal "n010"
    t.decimal "n011"
    t.decimal "n012"
    t.decimal "n013"
    t.decimal "n014"
    t.decimal "n015"
    t.decimal "n016"
    t.decimal "n017"
    t.decimal "n018"
    t.decimal "n019"
    t.decimal "n020"
    t.decimal "n021"
    t.decimal "n022"
    t.decimal "n023"
    t.decimal "n024"
    t.decimal "n025"
    t.decimal "n026"
    t.decimal "n027"
    t.decimal "n028"
    t.decimal "n029"
    t.decimal "n030"
    t.decimal "n031"
    t.decimal "n032"
    t.decimal "n033"
    t.decimal "n034"
    t.decimal "n035"
    t.decimal "n036"
    t.decimal "n037"
    t.decimal "n038"
    t.decimal "n039"
    t.decimal "n040"
    t.decimal "n041"
    t.decimal "n042"
    t.decimal "n043"
    t.decimal "n044"
    t.decimal "n045"
    t.decimal "n046"
    t.decimal "n047"
    t.decimal "n048"
    t.decimal "n049"
    t.decimal "n050"
    t.date "d001"
    t.date "d002"
    t.date "d003"
    t.date "d004"
    t.date "d005"
    t.date "d006"
    t.date "d007"
    t.date "d008"
    t.date "d009"
    t.date "d010"
    t.date "d011"
    t.date "d012"
    t.date "d013"
    t.date "d014"
    t.date "d015"
    t.date "d016"
    t.date "d017"
    t.date "d018"
    t.date "d019"
    t.date "d020"
    t.date "d021"
    t.date "d022"
    t.date "d023"
    t.date "d024"
    t.date "d025"
    t.date "d026"
    t.date "d027"
    t.date "d028"
    t.date "d029"
    t.date "d030"
    t.date "d031"
    t.date "d032"
    t.date "d033"
    t.date "d034"
    t.date "d035"
    t.date "d036"
    t.date "d037"
    t.date "d038"
    t.date "d039"
    t.date "d040"
    t.date "d041"
    t.date "d042"
    t.date "d043"
    t.date "d044"
    t.date "d045"
    t.date "d046"
    t.date "d047"
    t.date "d048"
    t.date "d049"
    t.date "d050"
    t.text "clob001"
    t.text "search_clob"
    t.index ["ws_app_id", "data_grid_id"], name: "apex$_ws_rows_idx"
  end

  create_table "apex$_ws_tags", id: :decimal, force: :cascade do |t|
    t.decimal "ws_app_id", null: false
    t.decimal "data_grid_id"
    t.decimal "row_id"
    t.decimal "webpage_id"
    t.string "component_level", limit: 30
    t.string "tag", limit: 4000
    t.date "created_on", null: false
    t.string "created_by", null: false
    t.date "updated_on"
    t.string "updated_by"
    t.index ["ws_app_id", "data_grid_id", "row_id"], name: "apex$_ws_tags_idx1"
    t.index ["ws_app_id", "webpage_id"], name: "apex$_ws_tags_idx2"
  end

  create_table "apex$_ws_webpg_section_history", id: false, force: :cascade do |t|
    t.decimal "section_id", null: false
    t.decimal "ws_app_id", null: false
    t.decimal "webpage_id", null: false
    t.decimal "old_display_sequence"
    t.decimal "new_display_sequence"
    t.string "old_title", limit: 4000
    t.string "new_title", limit: 4000
    t.text "old_content"
    t.text "new_content"
    t.string "application_user_id", null: false
    t.date "change_date", null: false
    t.index ["ws_app_id", "webpage_id", "section_id"], name: "apex$_ws_webpg_sechist_idx1"
  end

  create_table "apex$_ws_webpg_sections", id: :decimal, force: :cascade do |t|
    t.decimal "ws_app_id", null: false
    t.decimal "webpage_id"
    t.decimal "display_sequence"
    t.string "section_type", limit: 30, null: false
    t.string "title", limit: 4000
    t.text "content"
    t.text "content_upper"
    t.decimal "nav_start_webpage_id"
    t.decimal "nav_max_level"
    t.string "nav_include_link", limit: 1
    t.decimal "data_grid_id"
    t.decimal "report_id"
    t.decimal "data_section_style"
    t.string "chart_type"
    t.string "chart_3d", limit: 1
    t.string "chart_label"
    t.string "label_axis_title"
    t.string "chart_value"
    t.string "value_axis_title"
    t.string "chart_aggregate"
    t.string "chart_sorting"
    t.date "created_on", null: false
    t.string "created_by", null: false
    t.date "updated_on"
    t.string "updated_by"
  end

  create_table "demo_customers", primary_key: "customer_id", id: :decimal, force: :cascade do |t|
    t.string "cust_first_name", limit: 20, null: false
    t.string "cust_last_name", limit: 20, null: false
    t.string "cust_street_address1", limit: 60
    t.string "cust_street_address2", limit: 60
    t.string "cust_city", limit: 30
    t.string "cust_state", limit: 2
    t.string "cust_postal_code", limit: 10
    t.string "phone_number1", limit: 25
    t.string "phone_number2", limit: 25
    t.decimal "credit_limit", precision: 9, scale: 2
    t.string "cust_email", limit: 30
    t.index ["cust_last_name", "cust_first_name"], name: "demo_cust_name_ix"
  end

  create_table "demo_order_items", primary_key: "order_item_id", force: :cascade do |t|
    t.decimal "order_id", null: false
    t.decimal "product_id", null: false
    t.decimal "unit_price", precision: 8, scale: 2, null: false
    t.integer "quantity", limit: 8, precision: 8, null: false
  end

  create_table "demo_orders", primary_key: "order_id", id: :decimal, force: :cascade do |t|
    t.decimal "customer_id", null: false
    t.decimal "order_total", precision: 8, scale: 2
    t.date "order_timestamp"
    t.decimal "user_id"
    t.index ["customer_id"], name: "demo_ord_customer_ix"
  end

  create_table "demo_product_info", primary_key: "product_id", id: :decimal, force: :cascade do |t|
    t.string "product_name", limit: 50
    t.string "product_description", limit: 2000
    t.string "category", limit: 30
    t.string "product_avail", limit: 1
    t.decimal "list_price", precision: 8, scale: 2
    t.binary "product_image"
    t.string "mimetype"
    t.string "filename", limit: 400
    t.date "image_last_update"
  end

  create_table "demo_states", id: false, force: :cascade do |t|
    t.string "st", limit: 30
    t.string "state_name", limit: 30
  end

  create_table "demo_users", primary_key: "user_id", id: :decimal, force: :cascade do |t|
    t.string "user_name", limit: 100
    t.string "password", limit: 4000
    t.date "created_on"
    t.decimal "quota"
    t.string "products", limit: 1
    t.date "expires_on"
    t.string "admin_user", limit: 1
  end

  create_table "dept", primary_key: "deptno", force: :cascade do |t|
    t.string "dname", limit: 14
    t.string "loc", limit: 13
  end

  create_table "emp", primary_key: "empno", force: :cascade do |t|
    t.string "ename", limit: 10
    t.string "job", limit: 9
    t.integer "mgr", limit: 4, precision: 4
    t.date "hiredate"
    t.decimal "sal", precision: 7, scale: 2
    t.decimal "comm", precision: 7, scale: 2
    t.integer "deptno", limit: 2, precision: 2
  end

  create_table "households", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", limit: 19, precision: 19
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "joinable"
    t.index ["user_id"], name: "index_households_on_user_id"
  end

  create_table "invitations", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 19, precision: 19, null: false
    t.integer "household_id", limit: 19, precision: 19, null: false
    t.boolean "is_invitation", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["household_id", "user_id"], name: "i_inv_hou_id_use_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at", precision: 6
    t.string "reset_digest"
    t.datetime "reset_sent_at", precision: 6
    t.integer "household_id", precision: 38
    t.string "surname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["household_id"], name: "index_users_on_household_id"
  end

  add_foreign_key "apex$_ws_files", "apex$_ws_rows", column: "row_id", name: "apex$_ws_files_fk", on_delete: :cascade
  add_foreign_key "apex$_ws_links", "apex$_ws_rows", column: "row_id", name: "apex$_ws_links_fk", on_delete: :cascade
  add_foreign_key "apex$_ws_notes", "apex$_ws_rows", column: "row_id", name: "apex$_ws_notes_fk", on_delete: :cascade
  add_foreign_key "apex$_ws_tags", "apex$_ws_rows", column: "row_id", name: "apex$_ws_tags_fk", on_delete: :cascade
  add_foreign_key "demo_order_items", "demo_orders", column: "order_id", primary_key: "order_id", name: "demo_order_items_fk", on_delete: :cascade
  add_foreign_key "demo_order_items", "demo_product_info", column: "product_id", primary_key: "product_id", name: "demo_order_items_product_id_fk", on_delete: :cascade
  add_foreign_key "demo_orders", "demo_customers", column: "customer_id", primary_key: "customer_id", name: "demo_orders_customer_id_fk"
  add_foreign_key "demo_orders", "demo_users", column: "user_id", primary_key: "user_id", name: "demo_orders_user_id_fk"
  add_foreign_key "emp", "dept", column: "deptno", primary_key: "deptno", name: "sys_c007179"
  add_foreign_key "emp", "emp", column: "mgr", primary_key: "empno", name: "sys_c007178"
  add_foreign_key "users", "households"
end
