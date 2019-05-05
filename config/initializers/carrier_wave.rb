# frozen_string_literal: true

# Need for CarrierWave in development enviroment
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'



CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION']
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_attributes = {
      cache_control: "public, max-age=#{365.days.to_i}"
    }
    config.storage = :fog
    config.asset_host = ''
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
    config.asset_host = ''
  end
end