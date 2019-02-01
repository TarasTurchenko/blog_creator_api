Rails.application.routes.draw do
  get 'blogs/:blog_id/preview', to: 'blog_preview#index'

  mount MainApi::Root => '/'
end
