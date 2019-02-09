# frozen_string_literal: true

class CreateElements < ActiveRecord::Migration[5.2]
  def up
    create_table :elements
    add_column :elements, :container_id, :integer
    add_column :elements, :offset_top, :string
    add_column :elements, :offset_right, :string
    add_column :elements, :offset_bottom, :string
    add_column :elements, :offset_left, :string
    add_column :elements, :bg_image, :string
    add_column :elements, :bg_color, :string
    add_column :elements, :size, :integer
    add_column :elements, :position, :integer
    add_column :elements, :kind, :integer
    add_column :elements, :main_settings, :jsonb
    add_index :elements, :container_id
  end

  def down
    drop_table :elements
  end
end
