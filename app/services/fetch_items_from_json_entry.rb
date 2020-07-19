require "scrapper/engine"

class FetchItemsFromJsonEntry
  def initialize(json_entry)
    @json_entry = json_entry
    @json = JSON.parse(@json_entry.data)
  end

  def call
    ads = Scrapper::Engine.new(json: @json).call
    item_creator(ads)
  end

  def item_creator(ads)
    ads.each do |ad|
      Item.find_or_create_by(url: ad["url"]) do |ad2|
        ad2.title = ad["title"] if ad["title"]
        ad2.area = ad["area"] if ad["area"]
        ad2.price = ad["price"] if ad["price"]
        ad2.image = ad["image"] if ad["image"]
        ad2.url = ad["url"] if ad["url"]
        ad2.type = ad["type"] if ad["type"]
        ad2.zipcode = ad["zipcode"] if ad["zipcode"]
        ad2.city = ad["city"] if ad["city"]
        ad2.json_entry = @json_entry
      end
    end
  end
end
