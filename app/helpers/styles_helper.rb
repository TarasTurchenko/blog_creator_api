# frozen_string_literal: true

module StylesHelper
  def insert_styles(attributes)
    attributes = attributes.delete_if { |_, value| value.blank? }
    attributes = attributes.map { |property, value| "#{property}:#{value};" }
    attributes.join ''
  end

  def wrapper_styles(wrapper)
    insert_styles \
      'background-image': wrapper.bg_image,
      'background-color': wrapper.bg_color,
      'padding-top': wrapper.offset_top,
      'padding-right': wrapper.offset_right,
      'padding-bottom': wrapper.offset_bottom,
      'padding-left': wrapper.offset_left
  end
end
