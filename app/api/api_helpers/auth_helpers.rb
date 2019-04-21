# frozen_string_literal: true

module ApiHelpers
  module AuthHelpers
    attr_reader :current_user

    def authenticate!
      # TODO Uncomment it after adding front-end auth
      # @current_user = User.from_auth_token(headers['Authorization'])
      @current_user = User.last
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      unauthorized!
    end
  end
end
