# frozen_string_literal: true

module Services
  class BlogPublisher
    attr_accessor :blog, :dir, :html_path

    def initialize(blog)
      self.blog = blog
      self.dir = "blogs/#{blog.id}"
      self.html_path = "#{dir}/index.html"
    end

    def publish
      BlogWorker::Publish.perform_async(blog.id, html_path)
      page_url
    end

    def unpublish
      Helpers::Aws.delete_folder_from_storage(dir)
    end

    def page_url
      Helpers::Aws.build_cdn_url(html_path)
    end
  end
end
