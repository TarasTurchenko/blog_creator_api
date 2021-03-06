# frozen_string_literal: true

class FixFixPostDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :attrs,
                          thumbnail: '',
                          offsets: { top: 0, right: 0, bottom: 0, left: 0 },
                          bg_color: '#FFF',
                          bg_image: ''
  end
end
