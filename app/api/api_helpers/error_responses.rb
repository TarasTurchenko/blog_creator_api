# frozen_string_literal: true

module ApiHelpers
  module ErrorResponses
    def formatted_error!(code, status, message, errors = {})
      body = { code: code, message: message }
      (body[:errors] = errors) if errors.any?
      error!(body, status)
    end

    def unauthorized!
      message = I18n.t 'messages.errors.unauthorized'
      formatted_error!(:UNAUTHORIZED, 401, message)
    end

    def invalid_credentials!(errors = {})
      message = I18n.t 'messages.errors.invalid_credentials'
      formatted_error!(:INCORRECT_CREDENTIALS, 422, message, errors)
    end

    def create_blog!
      message = I18n.t 'messages.errors.create_blog'
      formatted_error!(:CREATE_BLOG, 422, message)
    end

    def not_found!
      message = I18n.t 'messages.errors.not_found'
      formatted_error!(:NOT_FOUND, 404, message)
    end
  end
end
