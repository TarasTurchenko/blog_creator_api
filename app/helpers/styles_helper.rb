# frozen_string_literal: true

module StylesHelper
  def format_styles(attributes)
    attributes = attributes.delete_if { |_, value| value.blank? }
    attributes = attributes.map { |property, value| "#{property}:#{value};" }
    attributes.join ''
  end

  def wrapper_styles(attrs)
    background = bg_styles(attrs['bg_image'], attrs['bg_color'])
    offsets = offsets_styles(attrs['offsets'])
    background + offsets
  end

  def offsets_styles(offsets)
    format_styles \
      'padding-top': "#{offsets['top']}px",
      'padding-right': "#{offsets['right']}%",
      'padding-bottom': "#{offsets['bottom']}px",
      'padding-left': "#{offsets['left']}%"
  end

  def bg_styles(image, color)
    format_styles('background-image': image, 'background-color': color)
  end
end
