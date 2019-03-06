# frozen_string_literal: true

module SharedApi
  module Helpers
    module ErrorResponses
      def formatted_error!(code, status, message)
        body = { code: code, message: message }
        error!(body, status)
      end

      def unauthorized!
        message = I18n.t 'messages.errors.unauthorized'
        formatted_error!('UNAUTHORIZED', 401, message)
      end

      def invalid_credentials!
        message = I18n.t 'messages.errors.invalid_credentials'
        formatted_error!('INCORRECT_CREDENTIALS', 422, message)
      end
    end
  end
end