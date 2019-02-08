Rails.application.routes.draw do
  get 'swagger', to: 'swagger#index'

  get 'blogs/:blog_id/preview', to: 'blog_preview#index'
  get 'posts/:post_id/preview', to: 'post_preview#index'

  mount MainApi::Root => '/'
end
