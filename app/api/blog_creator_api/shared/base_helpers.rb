# frozen_string_literal: true

module BlogCreatorApi
  module Shared
    module BaseHelpers
      def declared_params
        declared(params, include_missing: false)
      end
    end
  end
end