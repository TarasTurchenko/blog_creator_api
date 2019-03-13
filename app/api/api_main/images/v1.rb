# frozen_string_literal: true

module ApiMain
  module Images
    class V1 < Grape::API
      desc 'Upload image to storage and get cdn url to file'
      params do
        requires :src, type: String, desc: 'Base64 image'
        requires :extension, type: String
      end
      post :images do
        image = Image.new(params[:src], params[:extension])
        present :url, image.upload
      end
    end
  end
end
