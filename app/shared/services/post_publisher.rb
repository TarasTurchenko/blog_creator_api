# frozen_string_literal: true

module Services
  class PostPublisher
    attr_accessor :post, :html_path, :css_path, :dir_path

    def initialize(post)
      self.post = post
      self.dir_path = "blogs/#{post.blog_id}/posts/#{post.id}"
      self.html_path = "#{dir_path}/index.html"
      self.css_path = "#{dir_path}/styles.css"
    end

    def publish
      PostWorker::Publish.perform_async(post.id, html_path, css_path)
      page_url
    end

    def unpublish
      PostWorker::Unpublish.perform_async(dir_path)
    end

    def page_url
      Helpers::Aws.build_cdn_url(html_path)
    end
  end
end
