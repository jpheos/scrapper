# frozen_string_literal: true

class NotificationItemJob < ApplicationJob
  queue_as :default

  def perform(item_id)
    item = Item.find(item_id)
    SendItemWithPushbullet.call(item)
  end
end
