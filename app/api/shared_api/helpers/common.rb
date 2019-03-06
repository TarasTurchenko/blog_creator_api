# frozen_string_literal: true

module SharedApi
  module Helpers
    module Common
      def declared_params
        declared(params, include_missing: false)
      end
    end
  end
end
