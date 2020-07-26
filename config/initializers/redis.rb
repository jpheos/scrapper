# frozen_string_literal: true

$redis = Redis.new # rubocop:disable Style/GlobalVars

url = ENV['REDISCLOUD_URL']

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  $redis = Redis.new(url: url) # rubocop:disable Style/GlobalVars
end
