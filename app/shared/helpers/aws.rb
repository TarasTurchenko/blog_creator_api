# frozen_string_literal: true

module Helpers
  module Aws
    # @param [String] unique_key
    # @param [Array] items -- cache for these paths will reset
    def self.invalidate_cdn_paths(unique_key, items)
      CLOUDFRONT.create_invalidation(
        distribution_id: ENV['CLOUDFRONT_DISTRIBUTION'],
        invalidation_batch: {
          caller_reference: unique_key,
          paths: {
            quantity: items.length,
            items: items
          }
        }
      )
    end

    # @param [String] path to upload. eg blogs/5/index.html
    # @param [String] body
    def self.upload_to_storage(path, body)
      extension = path.split('.').last
      S3_BUCKET.put_object(
        acl: Constants::Storage::Permissions::PUBLIC_READ,
        body: body,
        content_type: "text/#{extension}",
        key: path
      )
    end

    def self.build_cdn_url(resource)
      "#{ENV['CDN_URL']}/#{resource}"
    end
  end
end