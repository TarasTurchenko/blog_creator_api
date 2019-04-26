# frozen_string_literal: true

module ApiMain
  module Images
    class V1 < BaseApi
      desc 'Upload image to storage and get cdn url to file'
      params do
        requires :image, type: File
      end
      post :images do
        image = Image.new
        image.file = ActionDispatch::Http::UploadedFile.new(params[:image])
        image.save!
        present(:url, image.file.url)
      end
    end
  end
end
