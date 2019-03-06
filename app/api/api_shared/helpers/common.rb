# frozen_string_literal: true

module ApiShared
  module Helpers
    module Common
      def declared_params
        declared(params, include_missing: false)
      end
    end
  end
end
