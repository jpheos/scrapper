# frozen_string_literal: true

class UpdateUserItemsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    items = FetchItemsFromUser.call(user)
    items.each do |item|
      NotificationItemJob.perform_later(item.id)
    end
  end
end
