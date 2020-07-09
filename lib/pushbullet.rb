# frozen_string_literal: true

class Pushbullet
  include HTTParty

  base_uri 'https://api.pushbullet.com/v2'

  def initialize(token:)
    @token = token
  end

  def devices
    response = self.class.get('/devices', options)
    data = JSON.parse response, symbolize_names: true
    data[:devices].select { |device| device[:active] }
  end

  def create_push(iden, data)
    post('/pushes', data.merge(device_iden: iden))
  end

  private

  def post(url, data)
    self.class.post(url, options.merge(body: data.to_json))
  end

  def options
    { headers: { 'Access-Token': @token, 'Content-Type': 'application/json' }, format: :plain }
  end
end
