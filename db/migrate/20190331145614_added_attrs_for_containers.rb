# frozen_string_literal: true

class AddedAttrsForContainers < ActiveRecord::Migration[5.2]
  def change
    remove_column :containers, :offset_top, :integer, default: 20
    remove_column :containers, :offset_right, :integer, default: 10
    remove_column :containers, :offset_bottom, :integer, default: 20
    remove_column :containers, :offset_left, :integer, default: 10
    remove_column :containers, :bg_color, :string, default: '#FFF'
    remove_column :containers, :bg_image, :string

    add_column :containers, :attrs, :jsonb, default: {
      offsets: { top: 20, right: 10, bottom: 20, left: 10 },
      bg_color: '#FFF',
      bg_image: ''
    }
  end
end
