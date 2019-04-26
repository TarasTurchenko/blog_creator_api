# frozen_string_literal: true

module Helpers
  def self.generate_uniq_key
    SecureRandom.hex(rand * 50) + '_' + DateTime.now.to_s
  end

  def self.build_server_path(relative_path)
    "#{ENV['APP_URL']}/#{relative_path}"
  end
end