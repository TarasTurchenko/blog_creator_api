# frozen_string_literal: true

module ViewModelHelper
  module Styles
    def render_inline_styles(attributes)
      attributes = attributes.delete_if { |_, value| value.blank? }
      attributes = attributes.map { |property, value| "#{property}:#{value};" }
      attributes.join('')
    end

    def render_wrapper_styles
      bg_image, bg_color, offsets = model.attrs.values_at('bg_image', 'bg_color', 'offsets')
      render_background_styles(bg_image, bg_color) + render_offsets_styles(offsets)
    end

    def render_offsets_styles(offsets)
      top, right, bottom, left = offsets.values_at('top', 'right', 'bottom', 'left')

      render_inline_styles(
        'padding-top': "#{top}px",
        'padding-right': "#{right}px",
        'padding-bottom': "#{bottom}px",
        'padding-left': "#{left}px"
      )
    end

    def render_background_styles(image, color)
      render_inline_styles('background-image': image, 'background-color': color)
    end
  end
end
