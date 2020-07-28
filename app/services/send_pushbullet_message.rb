# frozen_string_literal: true

require 'pushbullet'

class SendPushbulletMessage < ApplicationService
  def initialize(user, title, message)
    @user        = user
    @title       = title
    @message     = message
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
      type: 'note',
      title: @title,
      body: @message
    }
  end
end
