# frozen_string_literal: true

module PostViewModel
  module Element
    class Link < PostViewModel::Element::Base
      TEMPLATE_NAME = 'post/element/link'

      def link_destination
        return "#" unless publish_mode

        block = attrs['block']

        case block['destination_type']
        when 'post'
          ::Post.find(block['destination']).published_page_path
        when 'homepage'
          model.container.post.blog.published_page_path
        else
          block['destination']
        end
      end
    end
  end
end
