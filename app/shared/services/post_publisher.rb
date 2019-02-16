# frozen_string_literal: true

module Services
  class PostPublisher
    attr_accessor :post, :html_path, :css_path

    def initialize(post)
      self.post = post
      self.html_path = build_resource_path('index.html')
      self.css_path = build_resource_path('styles.css')
    end

    def publish
      post = prepare_post_data
      upload_html post
      upload_css post
    end

    def invalidation_items
      %W(/#{html_path} /#{css_path})
    end

    private

    def build_resource_path(name)
      "blogs/#{post.blog_id}/posts/#{post.id}/#{name}"
    end

    def prepare_post_data
      post = self.post.template_representation
      post.additional_styles = [
        build_cdn_path(css_path)
      ]
      post
    end

    def build_cdn_path(resource)
      "#{ENV['CDN_URL']}/#{resource}"
    end

    def upload_html(body)
      S3_BUCKET.put_object(
        acl: Constants::Storage::Permissions::PUBLIC_READ,
        body: render_html(body),
        content_type: 'text/html',
        key: html_path
      )
    end

    def render_html(post)
      ApplicationController.render(
        template: 'post/published',
        assigns: { post: post },
        layout: 'post/published'
      )
    end

    def upload_css(body)
      S3_BUCKET.put_object(
        acl: Constants::Storage::Permissions::PUBLIC_READ,
        body: render_css(body),
        content_type: 'text/css',
        key: css_path
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