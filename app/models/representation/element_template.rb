# frozen_string_literal: true

module Representation
  class ElementTemplate < Base
    attr_accessor(
      :id,
      :bg_color,
      :bg_image,
      :kind,
      :main_settings,
      :offset_bottom,
      :offset_left,
      :offset_right,
      :offset_top,
      :position,
      :size,
      :container_id
    )

    def initialize(model)
      self.attributes = model.attributes
    end

    def link_preview_destination
      raise BlogCreatorError, 'Element must be a link' if kind != 'link'

      destination = main_settings['destination']

      case main_settings['destination_type']
      when 'post'
        "/posts/#{destination}/preview"
      when 'homepage'
        "/blogs/#{blog_id}/preview"
      else
        destination
      end
    end
  end
end