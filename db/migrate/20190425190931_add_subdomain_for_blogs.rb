# frozen_string_literal: true

class AddSubdomainForBlogs < ActiveRecord::Migration[5.2]
  def up
    add_column :blogs, :subdomain, :string, null: true
    Blog.where(subdomain: nil).each { |blog| blog.update!(subdomain: blog.id) }
    change_column_null :blogs, :subdomain, null: false
    add_index :blogs, :subdomain, unique: true
  end

  def down
    remove_column :blogs, :subdomain
  end
end
