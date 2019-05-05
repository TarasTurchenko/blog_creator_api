# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  crypted_password :string
#  email            :string           not null
#  salt             :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :blog, dependent: :destroy

  validates :email, presence: true, format: { with: Config::Regexps::EMAIL }

  def self.from_auth_token(token)
    password = Rails.application.secrets.secret_key_base
    params = { algorithm: Config::Auth::TOKEN_ENCRYPTION }
    payload = JWT.decode(token, password, false, params)&.first || {}

    User.find(payload['post_id'])
  end

  def to_auth_token
    payload = { user_id: id }
    password = Rails.application.secrets.secret_key_base
    JWT.encode(payload, password, Config::Auth::TOKEN_ENCRYPTION)
  end
end
