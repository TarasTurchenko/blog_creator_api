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
  end
end