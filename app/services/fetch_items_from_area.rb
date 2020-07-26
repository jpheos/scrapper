# frozen_string_literal: true

# return an array of items creating from scrapping
class FetchItemsFromArea < ApplicationService
  def initialize(area)
    @area = area
  end

  def call
    @area.json_entries.map { |je| FetchItemsFromJsonEntry.call(je) }.flatten
  end
end
