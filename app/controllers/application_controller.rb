# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def home
    render json: { user: current_user, settings: current_user.pushbullet_setting }
  end
end
