module PostWorker
  class Publish < ApplicationWorker
    class BatchCallback
      def on_success(_, params = {})
        post = Post.find(params['post_id'])
        message = I18n.t('messages.success.post_published', post_title: post.title)
        NotificationsChannel.notify_success(post.blog.user, message)
      end
    end

    attr_accessor :post, :dir_path

    def perform(post_id, dir_path)
      self.post = Post.find(post_id)
      self.dir_path = dir_path

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
      Helpers::Aws.upload_to_storage(html_path, render_html(post))
    end

    def publish_styles(post)
      css_path = "#{dir_path}/styles.css"
      styles = CSS_COMPRESSOR.compress(render_css(post))
      Helpers::Aws.upload_to_storage(css_path, styles)
    end

    def render_html(post)
      styles_url = Helpers::Aws.build_cdn_url("#{dir_path}/styles.css")
      payload = { post: post, styles_url: styles_url }

      ApplicationController.render(
        template: 'post/index',
        assigns: payload,
        layout: 'post/published'
      )
    end

    def render_css(post)
      ApplicationController.render(
        template: 'post/styles',
        assigns: { post: post }
      )
    end

    def reset_caches
      batch = Sidekiq::Batch.new
      batch.on(:success, BatchCallback, post_id: post.id)
      batch.jobs { AssetsWorker::ResetCaches.perform_async("/#{dir_path}/*") }
    end
  end
end
