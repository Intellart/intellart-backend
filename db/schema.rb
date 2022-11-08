# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_07_150736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.integer "role", default: 0
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cardano_addresses", force: :cascade do |t|
    t.string "address"
    t.boolean "dirty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.bigint "unix_time"
    t.string "coin_id"
    t.decimal "usd"
    t.decimal "cad"
    t.decimal "eur"
    t.decimal "gbp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "nft_endorsers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "fingerprint"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "fingerprint"], name: "index_nft_endorsers_on_user_id_and_fingerprint", unique: true
    t.index ["user_id"], name: "index_nft_endorsers_on_user_id"
  end

  create_table "nft_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "fingerprint"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "fingerprint"], name: "index_nft_likes_on_user_id_and_fingerprint", unique: true
    t.index ["user_id"], name: "index_nft_likes_on_user_id"
  end

  create_table "nft_tags", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tag_id", null: false
    t.string "fingerprint"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id", "fingerprint"], name: "index_nft_tags_on_tag_id_and_fingerprint", unique: true
    t.index ["tag_id"], name: "index_nft_tags_on_tag_id"
    t.index ["user_id"], name: "index_nft_tags_on_user_id"
  end

  create_table "nfts", primary_key: "fingerprint", id: :string, force: :cascade do |t|
    t.boolean "tradeable"
    t.string "name"
    t.decimal "price"
    t.text "description"
    t.string "state"
    t.integer "sold_count", default: 0
    t.string "url"
    t.string "asset_name"
    t.string "policy_id"
    t.bigint "owner_id"
    t.bigint "cardano_address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cardano_address_id"], name: "index_nfts_on_cardano_address_id"
    t.index ["fingerprint"], name: "index_nfts_on_fingerprint", unique: true
    t.index ["owner_id"], name: "index_nfts_on_owner_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "rated_user_id"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rated_user_id"], name: "index_ratings_on_rated_user_id"
    t.index ["user_id", "rated_user_id"], name: "index_ratings_on_user_id_and_rated_user_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "study_fields", force: :cascade do |t|
    t.string "field_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.text "social_links"
    t.text "profile_img"
    t.string "orcid_id"
    t.bigint "study_field_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["study_field_id"], name: "index_users_on_study_field_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "nft_endorsers", "users"
  add_foreign_key "nft_likes", "users"
  add_foreign_key "nft_tags", "tags"
  add_foreign_key "nft_tags", "users"
  add_foreign_key "nfts", "cardano_addresses"
  add_foreign_key "nfts", "users", column: "owner_id"
  add_foreign_key "ratings", "users"
  add_foreign_key "ratings", "users", column: "rated_user_id"
  add_foreign_key "users", "study_fields"
end
