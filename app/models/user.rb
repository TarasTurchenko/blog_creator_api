class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, presence: true, format: { with: Constants::Regexps::EMAIL }

  def auth_token
    payload = { user_id: id }
    password = Rails.application.secrets.secret_key_base
    JWT.encode payload, password, 'HS256'
  end
end
