# frozen_string_literal: true

class AddTimestampsToPosts < ActiveRecord::Migration[5.2]
  def up
    add_timestamps :posts, null: true

    time = DateTime.now
    Post.update_all(created_at: time, updated_at: time)

    change_column_null :posts, :created_at, false
    change_column_null :posts, :updated_at, false
  end

  def down
    remove_timestamps :posts
  end
end
