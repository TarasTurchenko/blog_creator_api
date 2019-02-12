# frozen_string_literal: true

class Image
  attr_accessor :src, :relative_path

  def initialize(src, extension)
    self.src = Base64.decode64(src)
    self.relative_path = build_relative_path(extension)
  end

  def build_relative_path(extension)
    name = "#{generate_key(extension)}.#{extension}"
    "#{Constants::Storage::IMAGE_PATH}/#{name}"
  end

  def upload
    S3_BUCKET.put_object(
               key: relative_path,
               body: src,
               acl: Constants::Storage::IMAGE_PERMISSIONS
    )
    build_cdn_path
  end

  def build_cdn_path
    "#{ENV['CDN_URL']}/#{relative_path}"
  end

  def generate_key(extension)
    key = "#{extension}_#{src.length}_#{DateTime.now}"
    Digest::MD5.hexdigest key
  end
end