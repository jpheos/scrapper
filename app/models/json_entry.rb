# frozen_string_literal: true

class JsonEntry < ApplicationRecord
  belongs_to :area

  validates :name, presence: true
  validates :data, presence: true
end
