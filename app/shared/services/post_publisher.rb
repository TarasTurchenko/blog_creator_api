# frozen_string_literal: true

module Services
  class PostPublisher
    attr_accessor :post, :html_path, :css_path

    def initialize(post)
      self.post = post
      dir = "blogs/#{post.blog_id}/posts/#{post.id}"
      self.html_path = "#{dir}/index.html"
      self.css_path = "#{dir}/styles.css"
    end

    def publish
      post = self.post.template_representation(true)
      Helpers::Aws.upload_to_storage html_path, render_html(post)
      Helpers::Aws.upload_to_storage css_path, render_css(post)
    end

    def page_url
      Helpers::Aws.build_cdn_url(html_path)
    end

    private

    def render_html(post)
      styles_url = Helpers::Aws.build_cdn_url(css_path)

      ApplicationController.render(
        template: 'post/index',
        assigns: { post: post, styles_url: styles_url },
        layout: 'post/published'
      )
    end

    def render_css(post)
      ApplicationController.render(
        template: 'post/styles',
        assigns: { post: post }
      )
    end
  end
end
