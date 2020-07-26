# frozen_string_literal: true

require 'scrapper/engine'

# return an array of items creating from scrapping
class FetchItemsFromJsonEntry < ApplicationService
  ITEM_ATTRIBUTES = %w[title area price image url nature zipcode city].freeze

  def initialize(json_entry)
    @json_entry = json_entry
    @json       = JSON.parse(@json_entry.data)
  end

  def call
    call_scrapper_engine
    reorganize_json_keys
    filter_existing_items
    create_items
  end

  private

  def call_scrapper_engine
    @ads = Scrapper::Engine.new(json: @json, post_body: @json_entry.post_body).call
  end

  def reorganize_json_keys
    @ads.map do |ad|
      other = ad.delete('other')
      ad.merge!(other) if other
    end
  end

  def filter_existing_items
    urls           = @ads.map { |ad| ad['url'] }
    existing_urls  = Item.where(url: urls).pluck(:url)
    urls_to_create = urls - existing_urls

    @ads.select! { |ad| ad['url'].in? urls_to_create }
  end

  def create_items
    @ads.map do |ad|
      data = ad.slice(*ITEM_ATTRIBUTES)
      data[:json_entry] = @json_entry
      Item.create!(data)
    end
  end
end
