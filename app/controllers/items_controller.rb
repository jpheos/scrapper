class ItemsController < ApplicationController
  def index
    @items = current_user.items.order("id DESC")
  end
end
