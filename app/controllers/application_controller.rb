# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def home
    render json: current_user
  end
end
