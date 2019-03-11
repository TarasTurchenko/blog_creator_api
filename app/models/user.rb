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
  has_one :blog

  authenticates_with_sorcery!

  validates :email, presence: true, format: { with: Constants::Regexps::EMAIL }

  def auth_token
    payload = { user_id: id }
    password = Rails.application.secrets.secret_key_base
    JWT.encode payload, password, 'HS256'
  end
end
