# frozen_string_literal: true

module ViewModelHelper
  module Styles
    def render_inline_styles(attributes)
      attributes = attributes.delete_if { |_, value| value.blank? }
      attributes = attributes.map { |property, value| "#{property}:#{value};" }
      attributes.join('')
    end

    def render_wrapper_styles
      bg_image, bg_color = model.attrs.values_at('bg_image', 'bg_color')
      background_styles = render_background_styles(bg_image, bg_color)

      offsets_styles = render_offsets_styles(model.attrs['offsets'])
      background_styles + offsets_styles
    end

    def render_offsets_styles(offsets)
      render_inline_styles(
        'padding-top': "#{offsets['top']}px",
        'padding-right': "#{offsets['right']}px",
        'padding-bottom': "#{offsets['bottom']}px",
        'padding-left': "#{offsets['left']}px"
      )
    end

    def render_background_styles(image, color)
      render_inline_styles('background-image': image, 'background-color': color)
    end
  end
end
