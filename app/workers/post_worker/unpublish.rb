module PostWorker
  class Unpublish < ApplicationWorker
    def perform(post_id, dir_path)
      Helpers::Aws.delete_folder_from_storage(dir_path)
      AssetsWorker::ResetCaches.perform_async('/' + dir_path)

      post = Post.find(post_id)
      post.blog.publish
      post.update!(published: false)
    end
  end
end