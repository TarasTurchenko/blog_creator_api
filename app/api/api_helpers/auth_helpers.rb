# frozen_string_literal: true

module ApiHelpers
  module AuthHelpers
    attr_reader :current_user

    def authenticate!
      payload = jwt_payload headers['Authorization']

      @current_user = User.find(payload['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      unauthorized!
    end

    def jwt_payload(token)
      password = Rails.application.secrets.secret_key_base

      payload = JWT.decode(
        token,
        password,
        false,
        { algorithm: 'HS256' }
      )&.first

      payload || {}
    end
  end
end
