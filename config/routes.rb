# frozen_string_literal: true

Rails.application.routes.draw do
  mount RootApi => '/'
  mount GrapeSwaggerRails::Engine => '/api_docs'
end
