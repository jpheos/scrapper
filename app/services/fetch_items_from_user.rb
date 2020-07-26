# frozen_string_literal: true

# return an array of items creating from scrapping
class FetchItemsFromUser < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    @user.areas.map { |area| FetchItemsFromArea.call(area) }.flatten
  end
end
