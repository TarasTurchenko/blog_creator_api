class ImageUploader < CarrierWave::Uploader::Base
  def store_dir
    "images/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
