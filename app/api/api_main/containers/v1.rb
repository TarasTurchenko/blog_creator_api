# frozen_string_literal: true

module ApiMain
  module Containers
    class V1 < Grape::API
      namespace do
        helpers ApiHelpers::PostHelpers
        before { find_current_post! }
        desc 'Create new container'
        params do
          requires :post_id, type: Integer
          requires :position, type: Integer
        end
        post 'posts/:post_id/containers' do
          container = Container.create! declared_params
          present :container, container
        end
      end

      params do
        requires :container_id, type: Integer
      end
      resources 'containers/:container_id' do
        helpers ApiHelpers::ContainerHelpers
        before { find_current_container! }

        desc 'Update container settings'
        params do
          optional :offset_top, type: Integer
          optional :offset_right, type: Integer
          optional :offset_bottom, type: Integer
          optional :offset_left, type: Integer
          optional :bg_color, type: String
          optional :bg_image, type: String
        end
        put do
          current_container.update! declared_params.except(:container_id)
          present :container, current_container
        end

        desc 'Delete container and all elements for this container'
        delete do
          current_container.destroy!
          body false
        end

        desc 'Change container position inside page'
        params do
          requires :position, type: Integer
        end
        patch :position do
          current_container.move params[:position]
          nil
        end
      end
    end
  end
end
