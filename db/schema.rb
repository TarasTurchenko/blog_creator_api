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

ActiveRecord::Schema.define(version: 2019_01_29_215420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.boolean "published"
  end

  create_table "containers", force: :cascade do |t|
    t.string "offset_top"
    t.string "offset_rigth"
    t.string "offset_bottom"
    t.string "offset_left"
    t.string "bg_color"
    t.string "bg_image"
    t.integer "post_id"
    t.integer "position"
    t.index ["post_id"], name: "index_containers_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.boolean "published"
    t.string "offset_top"
    t.string "offset_right"
    t.string "offset_bottom"
    t.string "offset_left"
    t.string "bg_color"
    t.string "bg_image"
    t.string "thumbnail"
    t.integer "blog_id"
    t.index ["blog_id"], name: "index_posts_on_blog_id"
  end

end
