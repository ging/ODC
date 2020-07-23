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

ActiveRecord::Schema.define(version: 2020_07_23_115644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_ratings", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.boolean "enrolled"
    t.decimal "value", precision: 12, scale: 6
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_ratings_on_course_id"
    t.index ["user_id"], name: "index_course_ratings_on_user_id"
  end

  create_table "course_teachers", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.string "facebook"
    t.string "linkedin"
    t.string "twitter"
    t.string "instagram"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "course_teachers_courses", id: false, force: :cascade do |t|
    t.bigint "course_teacher_id"
    t.bigint "course_id"
    t.index ["course_id"], name: "index_course_teachers_courses_on_course_id"
    t.index ["course_teacher_id"], name: "index_course_teachers_courses_on_course_teacher_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "rating", precision: 12, scale: 6
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "start_enrollment_date"
    t.datetime "end_enrollment_date"
    t.boolean "webinar", default: false
    t.string "video"
    t.string "lang"
    t.string "url"
    t.string "powered_by"
    t.string "dedication"
    t.string "lessons"
    t.string "format"
    t.text "categories"
    t.text "contents"
    t.text "teachers_order"
    t.integer "visit_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumb_file_name"
    t.string "thumb_content_type"
    t.bigint "thumb_file_size"
    t.datetime "thumb_updated_at"
    t.string "powered_by_logo_file_name"
    t.string "powered_by_logo_content_type"
    t.bigint "powered_by_logo_file_size"
    t.datetime "powered_by_logo_updated_at"
    t.string "teaching_guide_file_name"
    t.string "teaching_guide_content_type"
    t.bigint "teaching_guide_file_size"
    t.datetime "teaching_guide_updated_at"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.integer "value", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.string "plain_name"
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "language"
    t.string "ui_language"
    t.text "tag_array_text", default: ""
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
