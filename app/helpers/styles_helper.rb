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
      'padding-top': "#{wrapper.offset_top}px",
      'padding-right': "#{wrapper.offset_right}%",
      'padding-bottom': "#{wrapper.offset_bottom}px",
      'padding-left': "#{wrapper.offset_left}%"
  end


  def new_wrapper_styles(wrapper)
    insert_styles \
      'background-image': wrapper.attrs['bg_image'],
      'background-color': wrapper.attrs['bg_color'],
      'padding-top': "#{wrapper.attrs['offsets']['top']}px",
      'padding-right': "#{wrapper.attrs['offsets']['right']}%",
      'padding-bottom': "#{wrapper.attrs['offsets']['bottom']}px",
      'padding-left': "#{wrapper.attrs['offsets']['left']}%"
    end
end
