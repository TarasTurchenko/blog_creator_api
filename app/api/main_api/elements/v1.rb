# frozen_string_literal: true

module MainApi
  module Elements
    class V1 < Grape::API
      version 'v1', using: :path

      desc 'Create new element'
      params do
        requires :container_id, type: Integer
        requires :position, type: Integer
        requires :kind, type: Symbol, values: Element::KINDS, desc: 'Type of element'
        requires :size, type: Integer
      end
      post 'containers/:container_id/elements' do
        Element.create! declared_params
      end

      desc 'Mass update elements sizes'
      params do
        requires :sizes, type: Array do
          requires :id, type: Integer
          requires :size, type: Integer
        end
      end
      patch 'elements/sizes' do
        Element.update_sizes declared_params[:sizes]
        body false
      end

      params do
        requires :element_id, type: Integer
      end
      resources 'elements/:element_id' do
        delete do
          Element.find(params[:element_id]).destroy!
          body false
        end
      end
    end
  end
end