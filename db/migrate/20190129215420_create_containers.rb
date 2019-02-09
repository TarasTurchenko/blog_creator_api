# frozen_string_literal: true

class CreateContainers < ActiveRecord::Migration[5.2]
  def up
    create_table :containers

    add_column :containers, :offset_top, :string
    add_column :containers, :offset_right, :string
    add_column :containers, :offset_bottom, :string
    add_column :containers, :offset_left, :string
    add_column :containers, :bg_color, :string
    add_column :containers, :bg_image, :string
    add_column :containers, :post_id, :integer
    add_column :containers, :position, :integer

    add_index :containers, :post_id
  end

  def down
    drop_table :containers
  end
end
