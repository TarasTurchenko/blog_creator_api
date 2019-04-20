module PostWorker
  class Unpublish < ApplicationWorker
    def perform(post_id, dir_path)
      Helpers::Aws.delete_folder_from_storage(dir_path)

      post = Post.find(post_id)
      post.update!(published: false)
      post.blog.sync_homepage
    end
  end
end