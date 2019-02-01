# frozen_string_literal: true

module MainApi
  module Containers
    class V1 < Grape::API
      version 'v1', using: :path

      params do
        requires :post_id, type: Integer
        requires :data, type: Hash do
          requires :position, type: Integer
        end
      end
      post 'posts/:post_id/containers' do
        position = params[:data][:position]
        Container.create! post_id: params[:post_id], position: position
      end

      params do
        requires :container_id, type: Integer
      end
      resources 'containers/:container_id' do
        params do
          requires :data, type: Hash do
            optional :offset_top, type: String
            optional :offset_right, type: String
            optional :offset_bottom, type: String
            optional :offset_left, type: String
            optional :bg_color, type: String
            optional :bg_image, type: String
          end
        end
        put do
          data = declared_params[:data]
          container = Container.find params[:container_id]
          container.update! data
          container
        end

        delete do
          container = Container.find params[:container_id]
          container.destroy!
          body false
        end

        params do
          requires :data, type: Hash do
            requires :position, type: Integer
          end
        end
        patch :position do
          container = Container.find params[:container_id]
          container.move params[:data][:position]
        end
      end
    end
  end
end