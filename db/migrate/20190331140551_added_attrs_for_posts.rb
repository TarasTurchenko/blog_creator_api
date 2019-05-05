# frozen_string_literal: true

class AddedAttrsForPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :offset_top, :integer
    remove_column :posts, :offset_right, :integer
    remove_column :posts, :offset_bottom, :integer
    remove_column :posts, :offset_left, :integer
    remove_column :posts, :bg_color, :string, default: '#FFF'
    remove_column :posts, :bg_image, :string
    remove_column :posts, :thumbnail, :string

    add_column :posts, :attrs, :jsonb, default: {
      thumbnail: 'https://d1y0dpztrh9xjz.cloudfront.net/assets/placeholder.png',
      offsets: { top: 0, right: 0, bottom: 0, left: 0 },
      bg_color: '#FFF',
      bg_image: ''
    }
  end
end
