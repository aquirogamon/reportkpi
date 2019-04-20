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

ActiveRecord::Schema.define(version: 2019_03_21_004343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accediandevices", force: :cascade do |t|
    t.string "site_name"
    t.string "name_device"
    t.string "type_device"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_interfaces", force: :cascade do |t|
    t.string "device"
    t.string "port"
    t.string "servicio"
    t.float "gbpsrx"
    t.float "gbpstx"
    t.float "bps_max"
    t.float "status"
    t.float "last_bps_max"
    t.float "last_status"
    t.float "crecimiento"
    t.float "egressRate"
    t.date "time"
    t.text "comment"
    t.integer "weeks", default: 0
    t.string "deviceindex"
    t.string "location"
    t.string "router"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id", default: 4
    t.index ["provider_id"], name: "index_core_interfaces_on_provider_id"
  end

  create_table "cpecac_interfaces", force: :cascade do |t|
    t.string "device"
    t.string "port"
    t.string "servicio"
    t.float "gbpsrx"
    t.float "gbpstx"
    t.float "bps_max"
    t.float "status"
    t.float "last_bps_max"
    t.float "last_status"
    t.float "crecimiento"
    t.float "egressRate"
    t.float "gbpsrx_95"
    t.float "gbpstx_95"
    t.date "time"
    t.text "comment"
    t.integer "weeks", default: 0
    t.string "deviceindex"
    t.string "index_opm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internet_interfaces", force: :cascade do |t|
    t.string "device"
    t.string "port"
    t.string "servicio"
    t.float "gbpsrx"
    t.float "gbpstx"
    t.float "bps_max"
    t.float "last_bps_max"
    t.float "last_status"
    t.float "crecimiento"
    t.float "status"
    t.float "egressRate"
    t.string "neighbor"
    t.date "time"
    t.text "comment"
    t.integer "weeks", default: 0
    t.string "deviceindex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id", default: 4
    t.index ["provider_id"], name: "index_internet_interfaces_on_provider_id"
  end

  create_table "internet_links", force: :cascade do |t|
    t.string "iru"
    t.string "tierone"
    t.string "location_usa"
    t.string "location_peru"
    t.string "device"
    t.string "port"
    t.string "lacp"
    t.string "id_iru"
    t.string "id_tierone"
    t.float "capacity"
    t.string "observation"
    t.date "time_activation"
    t.integer "time_iru", default: 0
    t.date "time_rest"
    t.string "status"
    t.string "name_iru"
    t.string "name_tierone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ipranaccess_qosegressinterfaces", force: :cascade do |t|
    t.string "device"
    t.string "sap"
    t.integer "queueId"
    t.float "bps_max"
    t.float "discard"
    t.float "discard_avg", default: 0.0
    t.date "time"
    t.text "comment"
    t.integer "weeks", default: 0
    t.string "device_sap"
    t.string "device_sapqueue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tx_provider_id", default: 8
    t.string "service"
    t.index ["tx_provider_id"], name: "index_ipranaccess_qosegressinterfaces_on_tx_provider_id"
  end

  create_table "ipranaccess_qosingressinterfaces", force: :cascade do |t|
    t.string "device"
    t.string "sap"
    t.integer "queueId"
    t.float "bps_max"
    t.float "discard"
    t.float "discard_avg", default: 8.0
    t.date "time"
    t.text "comment"
    t.integer "weeks", default: 0
    t.string "device_sap"
    t.string "device_sapqueue"
    t.string "service"
    t.bigint "tx_provider_id", default: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tx_provider_id"], name: "index_ipranaccess_qosingressinterfaces_on_tx_provider_id"
  end

  create_table "ipranedge_interface_saves", force: :cascade do |t|
    t.string "receivedTotalOctets"
    t.string "transmittedTotalOctets"
    t.string "timeCaptured"
    t.string "periodicTime"
    t.string "displayedName"
    t.string "monitoredObjectSiteName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ipranedge_interfaces", force: :cascade do |t|
    t.string "devicea"
    t.string "porta"
    t.string "descriptiona"
    t.float "egressRate"
    t.string "speed"
    t.float "gbpsrx"
    t.float "gbpstx"
    t.float "last_bps_max"
    t.float "last_status"
    t.float "bps_max"
    t.float "status"
    t.float "crecimiento"
    t.date "time"
    t.text "comment"
    t.integer "weeks", default: 0
    t.string "deviceindex"
    t.string "name_devicea"
    t.string "deviceb"
    t.string "portb"
    t.string "name_deviceb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id", default: 4
    t.index ["provider_id"], name: "index_ipranedge_interfaces_on_provider_id"
  end

  create_table "iprannet_qosegressinterfaces", force: :cascade do |t|
    t.string "device"
    t.string "port"
    t.integer "queueId"
    t.float "bps_max"
    t.float "discard"
    t.float "discard_avg"
    t.date "time"
    t.text "comment", default: "-"
    t.integer "weeks", default: 0
    t.string "device_port"
    t.string "device_portqueue"
    t.string "service", default: "-"
    t.bigint "tx_provider_id", default: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tx_provider_id"], name: "index_iprannet_qosegressinterfaces_on_tx_provider_id"
  end

  create_table "iprannet_qosingressinterfaces", force: :cascade do |t|
    t.string "device"
    t.string "port"
    t.integer "queueId"
    t.float "bps_max"
    t.float "discard"
    t.float "discard_avg"
    t.date "time"
    t.text "comment", default: "-"
    t.integer "weeks", default: 0
    t.string "device_port"
    t.string "device_portqueue"
    t.string "service", default: "-"
    t.bigint "tx_provider_id", default: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tx_provider_id"], name: "index_iprannet_qosingressinterfaces_on_tx_provider_id"
  end

  create_table "manager_sessions", force: :cascade do |t|
    t.string "ip_endpoint"
    t.string "name_endpoint"
    t.string "product_endpoint"
    t.string "state_endpoint"
    t.string "type_endpoint"
    t.string "capability"
    t.string "port_endpoint"
    t.string "tos_endpoint"
    t.string "name_session"
    t.string "sessionType"
    t.float "sid"
    t.string "dstEndpoint"
    t.float "dstPort"
    t.string "srcEndpoint"
    t.string "srcIfc"
    t.float "srcPort"
    t.string "state_session"
    t.float "interval_session"
    t.float "tos_session"
    t.float "payloadsize_session"
    t.float "pps_session"
    t.string "type_port"
    t.string "sla"
    t.string "status_device"
    t.string "ip_interface_vcx"
    t.float "dp50_p2r"
    t.float "dpmax_p2r"
    t.float "dpmin_p2r"
    t.float "lossPercent_p2r"
    t.float "dp50_r2p"
    t.float "dpmax_r2p"
    t.float "dpmin_r2p"
    t.float "lossPercent_r2p"
    t.float "delay_50"
    t.float "delay_max"
    t.float "delay_min"
    t.float "lossPercent_p2r_p95"
    t.float "lossPercent_r2p_p95"
    t.float "delay_50_p95"
    t.float "delay_max_p95"
    t.integer "events_delay50", default: 0
    t.integer "events_lossp2r", default: 0
    t.integer "events_lossr2p", default: 0
    t.bigint "accediandevice_id"
    t.bigint "tx_provider_id", default: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "discard", default: 0.0
    t.index ["accediandevice_id"], name: "index_manager_sessions_on_accediandevice_id"
    t.index ["tx_provider_id"], name: "index_manager_sessions_on_tx_provider_id"
  end

  create_table "preagg_interfaces", force: :cascade do |t|
    t.string "device"
    t.string "port"
    t.string "servicio"
    t.float "gbpsrx"
    t.float "gbpstx"
    t.float "bps_max"
    t.float "status"
    t.float "last_bps_max"
    t.float "last_status"
    t.float "crecimiento"
    t.float "egressRate"
    t.date "time"
    t.text "comment"
    t.integer "weeks", default: 0
    t.string "deviceindex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id", default: 4
    t.index ["provider_id"], name: "index_preagg_interfaces_on_provider_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sevone_sessions", force: :cascade do |t|
    t.string "session_name"
    t.integer "session_id"
    t.string "object_name"
    t.integer "object_id"
    t.string "device_name"
    t.integer "device_id"
    t.integer "device_elemets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statusnokia_ports", force: :cascade do |t|
    t.string "device"
    t.string "port"
    t.string "type_device"
    t.string "configurespeed"
    t.string "speed"
    t.string "description"
    t.string "status"
    t.string "service_all"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tx_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "displayname"
    t.string "title"
    t.integer "permission_level", default: 1
    t.index ["displayname"], name: "index_users_on_displayname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["title"], name: "index_users_on_title"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "core_interfaces", "providers"
  add_foreign_key "internet_interfaces", "providers"
  add_foreign_key "ipranaccess_qosegressinterfaces", "tx_providers"
  add_foreign_key "ipranaccess_qosingressinterfaces", "tx_providers"
  add_foreign_key "ipranedge_interfaces", "providers"
  add_foreign_key "iprannet_qosegressinterfaces", "tx_providers"
  add_foreign_key "iprannet_qosingressinterfaces", "tx_providers"
  add_foreign_key "manager_sessions", "accediandevices"
  add_foreign_key "manager_sessions", "tx_providers"
  add_foreign_key "preagg_interfaces", "providers"
end
