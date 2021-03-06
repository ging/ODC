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

ActiveRecord::Schema.define(version: 2021_06_22_124045) do

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

  create_table "course_similarities", force: :cascade do |t|
    t.bigint "course_a_id"
    t.bigint "course_b_id"
    t.decimal "value", precision: 12, scale: 6
    t.boolean "same_course_type"
    t.index ["course_a_id"], name: "index_course_similarities_on_course_a_id"
    t.index ["course_b_id"], name: "index_course_similarities_on_course_b_id"
  end

  create_table "course_teachers", force: :cascade do |t|
    t.string "name"
    t.string "position_es"
    t.string "facebook"
    t.string "linkedin"
    t.string "twitter"
    t.string "instagram"
    t.text "bio_es"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "position_en"
    t.string "position_ca"
    t.string "bio_en"
    t.string "bio_ca"
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
    t.string "alt_link"
    t.string "retransmission"
    t.string "powered_by_link"
    t.integer "spots"
    t.boolean "selfpaced"
    t.text "target_audience"
    t.string "thumb_min_file_name"
    t.string "thumb_min_content_type"
    t.bigint "thumb_min_file_size"
    t.datetime "thumb_min_updated_at"
    t.string "card_lang", default: "es"
    t.string "slug"
    t.text "suggestions"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.text "subject"
    t.text "body"
    t.text "rules"
    t.text "design"
    t.text "recipients"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
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
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "surname"
    t.boolean "subscribed_to_newsletters", default: true
    t.text "course_suggestions"
    t.text "webinar_suggestions"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "value"
    t.integer "occurrences", default: 0
  end

end
