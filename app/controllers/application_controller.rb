# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_areas

  def home
    render json: { user: current_user, settings: current_user.pushbullet_setting }
  end

  private

  def set_areas
    @areas_navbar = current_user.areas if current_user
  end
end
