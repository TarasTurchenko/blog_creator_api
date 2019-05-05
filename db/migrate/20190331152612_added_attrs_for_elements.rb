# frozen_string_literal: true

class AddedAttrsForElements < ActiveRecord::Migration[5.2]
  def change
    remove_column :elements, :offset_top, :integer, default: 5
    remove_column :elements, :offset_right, :integer, default: 5
    remove_column :elements, :offset_bottom, :integer, default: 5
    remove_column :elements, :offset_left, :integer, default: 5
    remove_column :elements, :bg_color, :string, default: '#FFF'
    remove_column :elements, :bg_image, :string
    remove_column :elements, :main_settings, :jsonb

    add_column :elements, :attrs, :jsonb, default: {
      offsets: { top: 20, right: 10, bottom: 20, left: 10 },
      bg_color: '#FFF',
      bg_image: '',
      block: {}
    }
  end
end
