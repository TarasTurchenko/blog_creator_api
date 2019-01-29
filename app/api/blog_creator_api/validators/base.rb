# frozen_string_literal: true

module BlogCreatorApi
  module Validators
    class Base < Grape::Validations::Base
      def reject(attr_name, message)
        params = [@scope.full_name(attr_name)]
        fail Grape::Exceptions::Validation, params: params, message: message
      end
    end
  end
end
