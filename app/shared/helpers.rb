# frozen_string_literal: true

module Helpers
  def self.generate_uniq_key
    SecureRandom.hex(rand * 50) + '_' + DateTime.now.to_s
  end
end
