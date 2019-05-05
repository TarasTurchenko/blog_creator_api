# frozen_string_literal: true

class AddTypeToElements < ActiveRecord::Migration[5.2]
  def change
    add_column :elements, :type, :string
  end
end
