# frozen_string_literal: true

class ImageUploader < BaseUploader
  def store_dir
    "images/#{model.id}"
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
