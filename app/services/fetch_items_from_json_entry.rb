# frozen_string_literal: true

require 'scrapper/engine'

class FetchItemsFromJsonEntry < ApplicationService
  def initialize(json_entry)
    @json_entry = json_entry
    @json       = JSON.parse(@json_entry.data)
  end

  def call
    call_scrapper_engine
    reorganize_json_keys
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

  def create_items
    @ads.each do |ad|
      Item.find_or_create_by(url: ad['url']) do |ad2|
        ad2.title      = ad['title'] if ad['title']
        ad2.area       = ad['area'] if ad['area']
        ad2.price      = ad['price'] if ad['price']
        ad2.image      = ad['image'] if ad['image']
        ad2.url        = ad['url'] if ad['url']
        ad2.nature     = ad['type'] if ad['type']
        ad2.zipcode    = ad['zipcode'] if ad['zipcode']
        ad2.city       = ad['city'] if ad['city']
        ad2.json_entry = @json_entry
      end
    end
  end
end
