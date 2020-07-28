# frozen_string_literal: true

class UpdateUserItemsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)
    @items = FetchItemsFromUser.call(@user)

    if @user.pushbullet_setting.nil?
      Rails.logger.debug "On ne peut pas notifier #{@user.email}, car pas de compte pushbullet de connecté."
    else
      notify_user
    end
  end

  private

  def send_pushbullet_job_success
    title = 'Scrap ok'
    message = 'On vient de scrapper, mais aucun nouveau resultat'
    SendPushbulletMessage.call(@user, title, message)
  end

  def notify_user
    if @items.empty?
      send_pushbullet_job_success(@user)
    else
      @items.each do |item|
        NotificationItemJob.perform_later(item.id)
      end
    end
  end
end
