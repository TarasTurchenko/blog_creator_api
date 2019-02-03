class AddedDefaultsForModels < ActiveRecord::Migration[5.2]
  def up
    change_column_default :blogs, :published, false

    change_column_default :posts, :published, false
    change_column_default :posts, :bg_color, '#FFF'

    change_column_default :containers, :offset_top, '20px'
    change_column_default :containers, :offset_right, '10%'
    change_column_default :containers, :offset_bottom, '20px'
    change_column_default :containers, :offset_left, '10%'
    change_column_default :containers, :bg_color, '#FFF'

    change_column_default :elements, :offset_top, '5px'
    change_column_default :elements, :offset_right, '5px'
    change_column_default :elements, :offset_bottom, '5px'
    change_column_default :elements, :offset_left, '5px'
    change_column_default :elements, :bg_color, '#FFF'
    change_column_default :elements, :main_settings, '{}'
  end

  def down
    change_column_default :blogs, :published, nil

    change_column_default :posts, :published, nil
    change_column_default :posts, :bg_color, nil

    change_column_default :containers, :offset_top, nil
    change_column_default :containers, :offset_right, nil
    change_column_default :containers, :offset_bottom, nil
    change_column_default :containers, :offset_left, nil
    change_column_default :containers, :bg_color, nil

    change_column_default :elements, :offset_top, nil
    change_column_default :elements, :offset_right, nil
    change_column_default :elements, :offset_bottom, nil
    change_column_default :elements, :offset_left, nil
    change_column_default :elements, :bg_color, nil
    change_column_default :elements, :main_settings, nil
  end
end
