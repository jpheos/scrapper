# frozen_string_literal: true

require 'oauth2'
require 'pushbullet'

class PushbulletController < ApplicationController
  before_action :check_pushbullet_setting, only: %i[devices devices_pick]
  skip_before_action :check_pushbullet

  def init
    client = OAuth2::Client.new(ENV['PUSHBULLET_CLIENT_ID'], ENV['PUSHBULLET_CLIENT_SECRET'], authorize_url: 'https://www.pushbullet.com/authorize')
    auth_url = client.auth_code.authorize_url(redirect_uri: pushbullet_callback_url)
    redirect_to auth_url
  end

  def callback
    client = OAuth2::Client.new(ENV['PUSHBULLET_CLIENT_ID'], ENV['PUSHBULLET_CLIENT_SECRET'], token_url: 'https://api.pushbullet.com/oauth2/token')
    auth_token = client.auth_code.get_token(params[:code])

    pushbullet_setting = PushbulletSetting.find_or_initialize_by(user_id: current_user.id)
    pushbullet_setting.access_token = auth_token.token
    pushbullet_setting.save!
    redirect_to pushbullet_devices_path
  end

  def devices
    @devices = pushbullet_client.devices.map { |d| d.slice(:iden, :nickname, :icon) }
  end

  def devices_pick
    current_user.pushbullet_setting.update!(device_iden: params[:iden])
    redirect_to root_path
  end

  private

  def check_pushbullet_setting
    redirect_to pushbullet_init_path unless current_user.pushbullet_setting
  end

  def pushbullet_client
    Pushbullet.new(token: current_user.pushbullet_setting.access_token)
  end
end
