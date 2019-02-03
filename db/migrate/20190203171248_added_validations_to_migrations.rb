class AddedValidationsToMigrations < ActiveRecord::Migration[5.2]
  def up
    change_column_null :blogs, :name, false
    change_column_null :blogs, :author, false

    change_column_null :posts, :title, false
    change_column_null :posts, :blog_id, false

    change_column_null :containers, :post_id, false
    change_column_null :containers, :position, false

    change_column_null :elements, :container_id, false
    change_column_null :elements, :size, false
    change_column_null :elements, :position, false
    change_column_null :elements, :kind, false
  end

  def down
    change_column_null :blogs, :name, true
    change_column_null :blogs, :author, true

    change_column_null :posts, :title, true
    change_column_null :posts, :blog_id, true

    change_column_null :containers, :post_id, true
    change_column_null :containers, :position, true

    change_column_null :elements, :container_id, true
    change_column_null :elements, :size, true
    change_column_null :elements, :position, true
    change_column_null :elements, :kind, true
  end
end
