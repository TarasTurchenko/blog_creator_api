# frozen_string_literal: true

class AddedPostDescriptions < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :description, :string
  end

  def down
    remove_column :posts, :description
  end
end
