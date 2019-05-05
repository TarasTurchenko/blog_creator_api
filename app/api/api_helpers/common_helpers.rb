# frozen_string_literal: true

module ApiHelpers
  module CommonHelpers
    def declared_params
      @declared_params ||= declared(params, include_missing: false)
      @declared_params
    end
  end
end
