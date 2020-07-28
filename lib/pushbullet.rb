# frozen_string_literal: true

class Pushbullet
  include HTTParty

  base_uri 'https://api.pushbullet.com/v2'

  def initialize(token:)
    @token = token
  end

  def devices
    @response = self.class.get('/devices', options)
    debug_quota
    data = JSON.parse @response, symbolize_names: true
    data[:devices].select { |device| device[:active] }
  end

  def create_push(iden, data)
    @response = post('/pushes', data.merge(device_iden: iden))
    debug_quota
  end

  private

  def post(url, data)
    self.class.post(url, options.merge(body: data.to_json))
  end

  def options
    { headers: { 'Access-Token': @token, 'Content-Type': 'application/json' }, format: :plain }
  end

  def debug_quota
    limit     = @response.headers['x-ratelimit-limit']
    remaining = @response.headers['x-ratelimit-remaining']
    reset     = @response.headers['x-ratelimit-reset']

    message = <<~TEXT
      ====== PUSHBULLET QUOTA ==============================
        📈 consumption:           #{remaining} / #{limit}
        🕑 hour to reset quota:   #{Time.at(reset.to_i)}
      ======================================================
    TEXT

    Rails.logger.info message
  end
end
