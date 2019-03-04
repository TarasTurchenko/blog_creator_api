class FixedOffsetsValues < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :offset_top, :string
    remove_column :posts, :offset_right, :string
    remove_column :posts, :offset_bottom, :string
    remove_column :posts, :offset_left, :string

    remove_column :containers, :offset_top, :string, default: '20px'
    remove_column :containers, :offset_right, :string, default: '10%'
    remove_column :containers, :offset_bottom, :string, default: '20px'
    remove_column :containers, :offset_left, :string, default: '10%'

    remove_column :elements, :offset_top, :string, default: '5px'
    remove_column :elements, :offset_right, :string, default: '5px'
    remove_column :elements, :offset_bottom, :string, default: '5px'
    remove_column :elements, :offset_left, :string, default: '5px'

    add_column :posts, :offset_top, :integer
    add_column :posts, :offset_right, :integer
    add_column :posts, :offset_bottom, :integer
    add_column :posts, :offset_left, :integer

    add_column :containers, :offset_top, :integer, default: 20
    add_column :containers, :offset_right, :integer, default: 10
    add_column :containers, :offset_bottom, :integer, default: 20
    add_column :containers, :offset_left, :integer, default: 10

    add_column :elements, :offset_top, :integer, default: 5
    add_column :elements, :offset_right, :integer, default: 5
    add_column :elements, :offset_bottom, :integer, default: 5
    add_column :elements, :offset_left, :integer, default: 5
  end
end
