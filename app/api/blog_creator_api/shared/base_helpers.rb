# frozen_string_literal: true

module BlogCreatorApi
  module Shared
    module BaseHelpers
      def params
        declared(super, include_missing: false)
      end
    end
  end
end