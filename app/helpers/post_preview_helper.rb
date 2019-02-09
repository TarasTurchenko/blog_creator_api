# frozen_string_literal: true

module PostPreviewHelper
  def wrapper_styles(wrapper)
    insert_styles \
      'background-image': wrapper.bg_image,
      'background-color': wrapper.bg_color,
      'padding-top': wrapper.offset_top,
      'padding-right': wrapper.offset_right,
      'padding-bottom': wrapper.offset_bottom,
      'padding-left': wrapper.offset_left
  end

  def build_element_size(size)
    "app-grid__element--#{size}"
  end
end
