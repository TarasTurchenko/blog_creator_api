# frozen_string_literal: true

module AssetsWorker
  class ResetCaches < ApplicationWorker
    def perform(*paths)
      Helpers::Aws.invalidate_cdn_paths(*paths)
    end
  end
end
