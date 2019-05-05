# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = authenticate
    end

    private

    def authenticate
      # TODO: Uncomment it after adding front-end auth
      # User.from_auth_token(headers['Authorization'])
      User.last
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      reject_unauthorized_connection
    end
  end
end
