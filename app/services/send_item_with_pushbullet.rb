# frozen_string_literal: true

require 'pushbullet'

class SendItemWithPushbullet < ApplicationService
  def initialize(item)
    @item = item
    @user = @item.json_entry.area.user
    @device_iden = @user.pushbullet_setting.device_iden
  end

  def call
    client.create_push(@device_iden, data)
  end

  private

  def client
    @client ||= Pushbullet.new(token: @user.pushbullet_setting.access_token)
  end

  def data
    {
      type: 'file',
      title: "[#{@item.json_entry.area.name.upcase}] #{@item.title}",
      body: body,
      file_name: 'photo.jpg',
      file_type: 'image/jpeg',
      file_url: 'https://www.rhone-saone-immo.com/wp-content/uploads/2020/07/rsi-1164118-1591727860-0-214x285.jpg',
      url: 'https://www.rhone-saone-immo.com/offres/vente-maison-210-m%c2%b2-a-le-montellier-325-000-e/'
    }
  end

  def body
    <<~TEXT
      📐 #{@item.area}
      💰 #{@item.price}
      🧭 #{@item.city}
    TEXT
  end
end
