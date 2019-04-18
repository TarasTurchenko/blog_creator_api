class RemoveKindAttrForElement < ActiveRecord::Migration[5.2]
  def change
    remove_column :elements, :kind, :string, null: false
  end
end
