# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def up
    create_table :posts

    add_column :posts, :title, :string
    add_column :posts, :published, :boolean
    add_column :posts, :offset_top, :string
    add_column :posts, :offset_right, :string
    add_column :posts, :offset_bottom, :string
    add_column :posts, :offset_left, :string
    add_column :posts, :bg_color, :string
    add_column :posts, :bg_image, :string
    add_column :posts, :thumbnail, :string
    add_column :posts, :blog_id, :integer

    add_index :posts, :blog_id
  end

  def down
    drop_table :posts
  end
end
