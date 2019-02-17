# frozen_string_literal: true

module MainApi
  module Images
    class V1 < Grape::API
      version 'v1', using: :path

      params do
        requires :src, type: String, desc: 'Base64 image'
        requires :extension, type: String
      end
      post :images do
        image = Image.new(params[:src], params[:extension])
        { url: image.upload }
      end
    end
  end
end
