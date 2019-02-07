class DeletedElementMainSettingsDefaults < ActiveRecord::Migration[5.2]
  def up
    change_column_default :elements, :main_settings, nil
  end

  def down
    change_column_default :elements, :main_settings, '{}'
  end
end
