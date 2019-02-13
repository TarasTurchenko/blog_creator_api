# frozen_string_literal: true

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
CLOUDFRONT = Aws::CloudFront::Client.new