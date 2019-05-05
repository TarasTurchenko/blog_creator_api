# frozen_string_literal: true

module PostWorker
  class Unpublish < ApplicationWorker
    def perform(post_id)
      post = Post.find(post_id)

      Helpers::Aws.delete_folder_from_storage(post.physical_dir_path)
      AssetsWorker::ResetCaches.perform_async("/#{post.physical_dir_path}/*")

      post.blog.publish
      post.update!(published: false)
    end
  end
end
