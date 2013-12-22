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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130520080133) do

  create_table "age_ranges", :force => true do |t|
    t.integer "low"
    t.integer "high"
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id", :null => false
    t.text     "content",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "is_active"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "assets", :force => true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "is_active"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "image_id"
    t.boolean  "is_active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["image_id"], :name => "index_categories_on_image_id"

  create_table "categories2_provider_categories", :force => true do |t|
    t.integer  "categories_id"
    t.integer  "provider_categories_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "categories2_provider_categories", ["categories_id"], :name => "index_categories2_provider_categories_on_categories_id"
  add_index "categories2_provider_categories", ["provider_categories_id"], :name => "index_categories2_provider_categories_on_provider_categories_id"

  create_table "content_item_age_ranges", :force => true do |t|
    t.integer  "contentItem_id", :null => false
    t.integer  "ageRange_id",    :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "content_item_age_ranges", ["ageRange_id"], :name => "index_content_item_age_ranges_on_ageRange_id"
  add_index "content_item_age_ranges", ["contentItem_id"], :name => "index_content_item_age_ranges_on_contentItem_id"

  create_table "content_item_family_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "content_items", :force => true do |t|
    t.integer  "category_id",                        :null => false
    t.string   "name"
    t.text     "description",        :default => ""
    t.integer  "profile_youtube_id"
    t.integer  "profile_itunes_id"
    t.integer  "profile_amazon_id"
    t.integer  "profile_faculty_id"
    t.integer  "views",                              :null => false
    t.integer  "shares",                             :null => false
    t.integer  "user_gender"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "is_active"
    t.boolean  "is_delete"
  end

  add_index "content_items", ["category_id"], :name => "index_content_items_on_category_id"
  add_index "content_items", ["profile_amazon_id"], :name => "index_content_items_on_profile_amazon_id"
  add_index "content_items", ["profile_faculty_id"], :name => "index_content_items_on_profile_faculty_id"
  add_index "content_items", ["profile_itunes_id"], :name => "index_content_items_on_profile_itunes_id"
  add_index "content_items", ["profile_youtube_id"], :name => "index_content_items_on_profile_youtube_id"

  create_table "content_items_amazons", :force => true do |t|
    t.integer      "item_id"
    t.string       "ean"
    t.hstore       "images"
    t.string_array "authors",         :limit => 255
    t.string       "isbn"
    t.integer      "edition"
    t.string       "currency"
    t.integer      "number_of_pages"
    t.date         "publish_date"
    t.string       "publisher"
    t.string       "manufacturer"
    t.string       "studio"
    t.string       "title"
    t.string       "uri"
    t.datetime     "created_at",                     :null => false
    t.datetime     "updated_at",                     :null => false
  end

  create_table "content_items_faculties", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "content_items_itunes", :force => true do |t|
    t.integer  "track_id"
    t.integer  "artist_id"
    t.integer  "collection_id"
    t.integer  "track_time_millis"
    t.string   "artist_name"
    t.string   "collectionArt_name"
    t.string   "artist_view_uri"
    t.string   "track_view_uri"
    t.string   "collection_view_uri"
    t.string   "preview_uri"
    t.string   "artwork_uri"
    t.float    "collection_price"
    t.float    "track_price"
    t.string   "country"
    t.string   "currency"
    t.string   "genre"
    t.string   "long_description"
    t.string   "item_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "content_items_youtubes", :force => true do |t|
    t.text     "embed_uri"
    t.text     "image_uri"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "author"
    t.string   "mobile_uri"
    t.string   "youtube_id"
    t.integer  "duration"
  end

  create_table "family_genders", :force => true do |t|
    t.string "name"
  end

  create_table "feelings", :force => true do |t|
    t.string   "name"
    t.string   "hex"
    t.integer  "sotyBy"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_active"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ue_id"
    t.integer  "notification_status_id"
    t.boolean  "is_sent"
    t.boolean  "is_read"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "ref_user_id"
  end

  create_table "notifications_statuses", :force => true do |t|
    t.boolean  "is_following"
    t.boolean  "is_ue_following"
    t.boolean  "is_ue_p"
    t.boolean  "is_feelike"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "page_views", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.boolean  "is_published"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "params", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "feeling_id",       :null => false
    t.integer  "content_item_id",  :null => false
    t.integer  "userExprience_id"
    t.text     "content",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "is_active"
    t.boolean  "is_delete"
    t.integer  "asset_id"
  end

  add_index "posts", ["content_item_id"], :name => "index_posts_on_content_item_id"
  add_index "posts", ["feeling_id"], :name => "index_posts_on_feeling_id"
  add_index "posts", ["userExprience_id"], :name => "index_posts_on_userExprience_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "posts_comments", :force => true do |t|
    t.integer  "users_id"
    t.integer  "content_items_id"
    t.text     "comment"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "post_id"
  end

  add_index "posts_comments", ["post_id"], :name => "index_posts_comments_on_post_id"

  create_table "provider_categories", :force => true do |t|
    t.string   "name"
    t.string   "provider_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "is_active"
  end

  create_table "push_configurations", :force => true do |t|
    t.string   "type",                           :null => false
    t.string   "app",                            :null => false
    t.text     "properties"
    t.boolean  "enabled",     :default => false, :null => false
    t.integer  "connections", :default => 1,     :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "push_feedback", :force => true do |t|
    t.string   "app",                             :null => false
    t.string   "device",                          :null => false
    t.string   "type",                            :null => false
    t.string   "follow_up",                       :null => false
    t.datetime "failed_at",                       :null => false
    t.boolean  "processed",    :default => false, :null => false
    t.datetime "processed_at"
    t.text     "properties"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "push_feedback", ["processed"], :name => "index_push_feedback_on_processed"

  create_table "push_messages", :force => true do |t|
    t.string   "app",                                  :null => false
    t.string   "device",                               :null => false
    t.string   "type",                                 :null => false
    t.text     "properties"
    t.boolean  "delivered",         :default => false, :null => false
    t.datetime "delivered_at"
    t.boolean  "failed",            :default => false, :null => false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.string   "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "push_messages", ["delivered", "failed", "deliver_after"], :name => "index_push_messages_on_delivered_and_failed_and_deliver_after"

  create_table "questions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_active"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stats_content_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "feeling_id"
    t.integer  "feelike_count"
    t.integer  "todo_counter"
    t.integer  "comments_counter"
    t.integer  "ue_counter"
    t.integer  "overall_counter"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "user_expirance_access_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_expirance_activity_to_access_types", :force => true do |t|
    t.integer  "type_id_id"
    t.integer  "ue_id_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_expirance_activity_to_access_types", ["type_id_id"], :name => "index_user_expirance_activity_to_access_types_on_type_id_id"
  add_index "user_expirance_activity_to_access_types", ["ue_id_id"], :name => "index_user_expirance_activity_to_access_types_on_ue_id_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "is_active"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "users_answers", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "answer_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users_answers", ["answer_id"], :name => "index_users_answers_on_answer_id"
  add_index "users_answers", ["user_id"], :name => "index_users_answers_on_user_id"

  create_table "users_content_items", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "content_item_id",  :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "is_todo"
    t.boolean  "is_feelike"
    t.integer  "feeling_id"
    t.boolean  "is_delete"
    t.boolean  "is_active"
    t.integer  "user_exprance_id"
    t.integer  "asset_id"
  end

  add_index "users_content_items", ["content_item_id"], :name => "index_users_content_items_on_content_item_id"
  add_index "users_content_items", ["feeling_id"], :name => "index_users_content_items_on_feeling_id"
  add_index "users_content_items", ["user_exprance_id"], :name => "index_users_content_items_on_user_exprance_id"
  add_index "users_content_items", ["user_id"], :name => "index_users_content_items_on_user_id"

  create_table "users_exprience2_categories", :force => true do |t|
    t.integer  "ue_id"
    t.integer  "ue_categoy_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users_exprience_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users_exprience_categories2_tags", :force => true do |t|
    t.integer  "cat_id"
    t.integer  "cat_tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users_exprience_categories_tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users_exprience_followers", :force => true do |t|
    t.integer  "users_id"
    t.integer  "users_expriences_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "users_exprience_followers", ["users_expriences_id"], :name => "index_users_exprience_followers_on_users_expriences_id"
  add_index "users_exprience_followers", ["users_id"], :name => "index_users_exprience_followers_on_users_id"

  create_table "users_exprience_images", :force => true do |t|
    t.integer  "user_exp_id", :null => false
    t.integer  "user_id",     :null => false
    t.integer  "image_id",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "users_exprience_images", ["image_id"], :name => "index_users_exprience_images_on_image_id"
  add_index "users_exprience_images", ["user_exp_id"], :name => "index_users_exprience_images_on_user_exp_id"
  add_index "users_exprience_images", ["user_id"], :name => "index_users_exprience_images_on_user_id"

  create_table "users_exprience_participants", :force => true do |t|
    t.integer  "user_exp_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "users_exprience_participants", ["user_exp_id"], :name => "index_users_exprience_participants_on_user_exp_id"
  add_index "users_exprience_participants", ["user_id"], :name => "index_users_exprience_participants_on_user_id"

  create_table "users_expriences", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "image_id"
    t.text     "content",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_private"
    t.string   "name"
    t.boolean  "is_active"
    t.boolean  "is_delete"
  end

  add_index "users_expriences", ["image_id"], :name => "index_users_expriences_on_image_id"
  add_index "users_expriences", ["user_id"], :name => "index_users_expriences_on_user_id"

  create_table "users_follows", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "ref_user_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "users_follows", ["ref_user_id"], :name => "index_users_follows_on_ref_user_id"
  add_index "users_follows", ["user_id"], :name => "index_users_follows_on_user_id"

  create_table "users_profiles", :force => true do |t|
    t.string   "fname",            :null => false
    t.string   "lname",            :null => false
    t.date     "birthDate",        :null => false
    t.string   "gender",           :null => false
    t.integer  "image_id"
    t.text     "bio"
    t.integer  "user_id",          :null => false
    t.integer  "family_gender_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "users_profiles", ["family_gender_id"], :name => "index_users_profiles_on_family_gender_id"
  add_index "users_profiles", ["image_id"], :name => "index_users_profiles_on_image_id"
  add_index "users_profiles", ["user_id"], :name => "index_users_profiles_on_user_id"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "users_settings", :force => true do |t|
    t.integer  "user_id",             :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "is_private_post"
    t.integer  "experience_p_status"
    t.integer  "feelike_status"
    t.integer  "comment_status"
    t.integer  "follows_status"
    t.integer  "experience_status"
    t.string   "mobile_token"
  end

  add_index "users_settings", ["user_id"], :name => "index_users_settings_on_user_id"

  create_table "users_socals", :force => true do |t|
    t.integer  "users_id"
    t.boolean  "has_twitter"
    t.string   "twitter_token"
    t.boolean  "has_facebook"
    t.string   "facebook_token"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "fb_id"
  end

  add_index "users_socals", ["users_id"], :name => "index_users_socals_on_users_id"

end
