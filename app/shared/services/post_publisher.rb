# frozen_string_literal: true

module Services
  class PostPublisher
    attr_accessor :post, :dir

    def initialize(post)
      self.post = post
      self.dir = "blogs/#{post.blog_id}/posts/#{post.id}"
    end

    def publish
      post = prepare_post_data
      Helpers::Aws.upload_to_storage "#{dir}/index.html", render_html(post)
      Helpers::Aws.upload_to_storage "#{dir}/index.css", render_css(post)
    end

    private

    def prepare_post_data
      post = self.post.template_representation
      post.additional_styles = [
        Helpers::Aws.build_cdn_url("#{dir}/index.css")
      ]
      post
    end

    def render_html(post)
      ApplicationController.render(
        template: 'post/published',
        assigns: { post: post },
        layout: 'post/published'
      )
    end

    def render_css(post)
      ApplicationController.render(
        template: 'post/published_styles',
        assigns: { post: post }
      )
    end
  end
end