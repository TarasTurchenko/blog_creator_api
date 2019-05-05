# frozen_string_literal: true

SIDEKIQ_REDIS_URL = "#{ENV['REDIS_URL']}/0"

Sidekiq.configure_server do |config|
  config.redis = { url: SIDEKIQ_REDIS_URL }
end
Sidekiq.configure_client do |config|
  config.redis = { url: SIDEKIQ_REDIS_URL }
end
