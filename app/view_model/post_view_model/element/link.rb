# frozen_string_literal: true

module PostViewModel
  module Element
    class Link < PostViewModel::Element::Base
      TEMPLATE_NAME = 'post/element/link'

      def link_destination
        return "#" unless publish_mode

        type, target = attrs['block'].values_at('destination_type', 'destination')

        case type
        when 'post'
          ::Post.find(target).published_page_path
        when 'homepage'
          model.container.post.blog.published_page_path
        else
          target
        end
      end
    end
  end
end
