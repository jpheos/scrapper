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
      file_url: @item.image,
      url: @item.url
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
