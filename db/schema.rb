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

ActiveRecord::Schema[7.0].define(version: 2023_01_12_121134) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
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
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
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
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "blog_article_comments", force: :cascade do |t|
    t.bigint "blog_article_id", null: false
    t.bigint "commenter_id"
    t.bigint "reply_to_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes"
    t.integer "dislikes"
    t.index ["blog_article_id"], name: "index_blog_article_comments_on_blog_article_id"
    t.index ["commenter_id"], name: "index_blog_article_comments_on_commenter_id"
    t.index ["reply_to_id"], name: "index_blog_article_comments_on_reply_to_id"
  end

  create_table "blog_article_tags", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "blog_article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_article_id"], name: "index_blog_article_tags_on_blog_article_id"
    t.index ["tag_id"], name: "index_blog_article_tags_on_tag_id"
  end

  create_table "blog_articles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "title"
    t.text "subtitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes"
    t.string "status"
    t.text "description"
    t.string "image"
    t.boolean "star"
    t.jsonb "content"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_blog_articles_on_category_id"
    t.index ["user_id"], name: "index_blog_articles_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.bigint "unix_time"
    t.string "coin_id"
    t.decimal "usd"
    t.decimal "cad"
    t.decimal "eur"
    t.decimal "gbp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "good_job_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "state"
  end

  create_table "good_job_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "key"
    t.jsonb "value"
    t.index ["key"], name: "index_good_job_settings_on_key", unique: true
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "queue_name"
    t.integer "priority"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "active_job_id"
    t.text "concurrency_key"
    t.text "cron_key"
    t.uuid "retried_good_job_id"
    t.datetime "cron_at"
    t.index ["active_job_id", "created_at"], name: "index_good_jobs_on_active_job_id_and_created_at"
    t.index ["active_job_id"], name: "index_good_jobs_on_active_job_id"
    t.index ["concurrency_key"], name: "index_good_jobs_on_concurrency_key_when_unfinished", where: "(finished_at IS NULL)"
    t.index ["cron_key", "created_at"], name: "index_good_jobs_on_cron_key_and_created_at"
    t.index ["cron_key", "cron_at"], name: "index_good_jobs_on_cron_key_and_cron_at", unique: true
    t.index ["finished_at"], name: "index_good_jobs_jobs_on_finished_at", where: "((retried_good_job_id IS NULL) AND (finished_at IS NOT NULL))"
    t.index ["priority", "created_at"], name: "index_good_jobs_jobs_on_priority_created_at_when_unfinished", order: { priority: "DESC NULLS LAST" }, where: "(finished_at IS NULL)"
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "nft_endorsers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "fingerprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "fingerprint"], name: "index_nft_endorsers_on_user_id_and_fingerprint", unique: true
    t.index ["user_id"], name: "index_nft_endorsers_on_user_id"
  end

  create_table "nft_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "fingerprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "fingerprint"], name: "index_nft_likes_on_user_id_and_fingerprint", unique: true
    t.index ["user_id"], name: "index_nft_likes_on_user_id"
  end

  create_table "nft_tags", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tag_id", null: false
    t.string "fingerprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.serial "nft_id"
    t.string "tx_id"
    t.string "witness"
    t.string "seller_address"
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_nfts_on_category_id"
    t.index ["fingerprint"], name: "index_nfts_on_fingerprint", unique: true
    t.index ["owner_id"], name: "index_nfts_on_owner_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "rated_user_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rated_user_id"], name: "index_ratings_on_rated_user_id"
    t.index ["user_id", "rated_user_id"], name: "index_ratings_on_user_id_and_rated_user_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "study_fields", force: :cascade do |t|
    t.string "field_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.text "social_links"
    t.text "profile_img"
    t.string "orcid_id"
    t.bigint "study_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["study_field_id"], name: "index_users_on_study_field_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blog_article_comments", "blog_article_comments", column: "reply_to_id"
  add_foreign_key "blog_article_comments", "blog_articles"
  add_foreign_key "blog_article_comments", "users", column: "commenter_id"
  add_foreign_key "blog_article_tags", "blog_articles"
  add_foreign_key "blog_article_tags", "tags"
  add_foreign_key "blog_articles", "categories"
  add_foreign_key "blog_articles", "users"
  add_foreign_key "nft_endorsers", "users"
  add_foreign_key "nft_likes", "users"
  add_foreign_key "nft_tags", "tags"
  add_foreign_key "nft_tags", "users"
  add_foreign_key "nfts", "categories"
  add_foreign_key "nfts", "users", column: "owner_id"
  add_foreign_key "ratings", "users"
  add_foreign_key "ratings", "users", column: "rated_user_id"
  add_foreign_key "users", "study_fields"
end
