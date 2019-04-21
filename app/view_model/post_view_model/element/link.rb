# frozen_string_literal: true

module PostViewModel
  module Element
    class Link < PostViewModel::Element::Base
      def link_destination
        block = attrs['block']
        destination = block['destination']

        case block['destination_type']
        when 'post'
          post_path(destination)
        when 'homepage'
          homepage_path
        else
          destination
        end
      end

      private

      def current_post
        model.container.post
      end

      def post_path(post_id)
        return "#" unless publish_mode

        published_post_path(post_id)
      end

      def published_post_path(post_id)
        blog_dir_path = current_post.published_directory_path
        Helpers::Aws.build_cdn_url("#{blog_dir_path}/#{post_id}/index.html")
      end

      def homepage_path
        return '#' unless publish_mode
        published_homepage_path
      end

      def published_homepage_path
        Helpers::Aws.build_cdn_url(current_post.blog.published_page_path)
      end
    end
  end
end
