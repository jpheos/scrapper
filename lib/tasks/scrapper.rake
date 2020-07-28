# frozen_string_literal: true

namespace :scrapper do
  task users: :environment do
    User.pluck(:id).each do |user_id|
      UpdateUserItemsJob.perform_later(user_id)
    end
  end
end
