module PostWorker
  class Destroy < ApplicationWorker
    def perform(post_id)
      post = Post.find(post_id)
      post.destroy!
      post.unpublish
    end
  end
end