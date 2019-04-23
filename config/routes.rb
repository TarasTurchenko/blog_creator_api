# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/api_docs'
  mount Sidekiq::Web => '/sidekiq'
  mount RootApi => '/'
end
