# frozen_string_literal: true

module PostWorker
  class Publish < ApplicationWorker
    class BatchCallback
      def on_success(_status, params = {})
        post = Post.find(params['post_id'])

        message_params = { post_title: post.title }
        message = I18n.t('messages.success.post_published', message_params)

        NotificationsChannel.notify_success(post.blog.user, message)
      end
    end

    attr_accessor :post, :dir_path

    def perform(post_id)
      self.post = Post.find(post_id)
      self.dir_path = post.physical_dir_path

      publish
      post.blog.publish

      reset_caches

      post.update!(published: true) unless post.published
    end

    private

    def publish
      post = PostViewModel::Post.new(self.post, true)
      publish_html(post)
      publish_styles(post)
    end

    def publish_html(post)
      html_path = "#{dir_path}/index.html"
      Helpers::Aws.upload_to_storage(html_path, post.render_html)
    end

    def publish_styles(post)
      css_path = "#{dir_path}/styles.css"
      styles = CSS_COMPRESSOR.compress(post.render_styles)
      Helpers::Aws.upload_to_storage(css_path, styles)
    end

    def reset_caches
      batch = Sidekiq::Batch.new
      batch.on(:success, BatchCallback, post_id: post.id)
      batch.jobs { AssetsWorker::ResetCaches.perform_async("/#{dir_path}/*") }
    end
  end
end
