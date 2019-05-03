# frozen_string_literal: true

AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  config.fog_directory = ENV['S3_BUCKET']
  config.fog_region = ENV['AWS_REGION']
end