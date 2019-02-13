class AddedBlogPublishKeys < ActiveRecord::Migration[5.2]
  def up
    add_column :blogs, :publish_key, :string
    add_index :blogs, :publish_key, unique: true
  end

  def down
    remove_column :blogs, :publish_key
  end
end
