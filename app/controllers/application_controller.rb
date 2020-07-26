# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :check_pushbullet

  def home
    render json: { user: current_user, settings: current_user.pushbullet_setting }
  end

  def check_pushbullet
    redirect_to pushbullet_init_path if current_user.pushbullet_setting.nil?
    redirect_to pushbullet_init_path if current_user && current_user.pushbullet_setting.nil?
  end
end
