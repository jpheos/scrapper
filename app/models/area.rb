# frozen_string_literal: true

class Area < ApplicationRecord
  belongs_to :user
  has_many :json_entries, dependent: :destroy
  has_many :items, through: :json_entries
end
