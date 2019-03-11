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

ActiveRecord::Schema.define(version: 2019_03_07_055426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.string "name", null: false
    t.string "author", null: false
    t.boolean "published", default: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "containers", force: :cascade do |t|
    t.string "bg_color", default: "#FFF"
    t.string "bg_image"
    t.integer "post_id", null: false
    t.integer "position", null: false
    t.integer "offset_top", default: 20
    t.integer "offset_right", default: 10
    t.integer "offset_bottom", default: 20
    t.integer "offset_left", default: 10
    t.index ["post_id"], name: "index_containers_on_post_id"
  end

  create_table "elements", force: :cascade do |t|
    t.integer "container_id", null: false
    t.string "bg_image"
    t.string "bg_color", default: "#FFF"
    t.integer "size", null: false
    t.integer "position", null: false
    t.integer "kind", null: false
    t.jsonb "main_settings"
    t.integer "offset_top", default: 5
    t.integer "offset_right", default: 5
    t.integer "offset_bottom", default: 5
    t.integer "offset_left", default: 5
    t.index ["container_id"], name: "index_elements_on_container_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "published", default: false
    t.string "bg_color", default: "#FFF"
    t.string "bg_image"
    t.string "thumbnail"
    t.integer "blog_id", null: false
    t.string "description"
    t.integer "offset_top"
    t.integer "offset_right"
    t.integer "offset_bottom"
    t.integer "offset_left"
    t.index ["blog_id"], name: "index_posts_on_blog_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "blogs", "users"
end
