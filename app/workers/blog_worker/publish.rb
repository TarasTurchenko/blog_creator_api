# frozen_string_literal: true

module BlogWorker
  class Publish < ApplicationWorker
    attr_accessor :blog, :html_path

    def perform(blog_id)
      self.blog = Blog.find(blog_id)
      self.html_path = "#{blog.physical_dir_path}/index.html"

      publish

      AssetsWorker::ResetCaches.perform_async('/' + html_path)

      blog.update!(published: true) unless blog.published
    end

    private

    def publish
      blog = BlogViewModel::Blog.new(self.blog, true)
      Helpers::Aws.upload_to_storage(html_path, blog.render_html)
    end
  end
end
