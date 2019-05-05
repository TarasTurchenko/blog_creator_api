# frozen_string_literal: true

class AddImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :file
    end
  end
end
