class CreateBlogs < ActiveRecord::Migration[5.2]
  def up
    create_table :blogs
    add_column :blogs, :name, :string
    add_column :blogs, :author, :string
    add_column :blogs, :published, :boolean
  end

  def down
    drop_table :blogs
  end
end
