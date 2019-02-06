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
    end
  end
end