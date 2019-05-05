# frozen_string_literal: true

class FixSubdomainNullables < ActiveRecord::Migration[5.2]
  def up
    Blog.where(subdomain: nil).each { |blog| blog.update!(subdomain: blog.id) }
    change_column_null :blogs, :subdomain, false
  end

  def down
    change_column_null :blogs, :subdomain, false
  end
end
