# frozen_string_literal: true

require_relative './selector.rb'

require 'open-uri'
require 'uri'

class Scrapper::Engine
  def initialize(json:, post_body: nil)
    @start_url = json['startUrl'].first
    @post_body = post_body
    extract_domain
    @selectors = json['selectors'].map { |s| Scrapper::Selector.from_json(s, @domain) }
    generate_sitemap
  end

  def debug_selector(selector, i = 0) # rubocop:disable Naming/MethodParameterName
    print '-' * i
    ap selector.id
    selector.children.each do |s|
      debug_selector(s, i + 2)
    end
  end

  def call
    uri = URI(@start_url)
    res = @post_body ? Net::HTTP.post(uri, @post_body) : Net::HTTP.get_response(uri)
    doc = Nokogiri::HTML(res.body)
    first_selector = @selectors.find { |s| s.parent_selector == '_root' }
    # debug_selector(first_selector)
    # ap first_selector.data(doc)
    first_selector.data(doc)
  end

  def generate_sitemap
    @selectors.each do |selector|
      selector.children = @selectors.select { |s| s.parent_selector == selector.id }
    end
  end

  def extract_domain
    uri = URI.parse(@start_url)
    @domain = "#{uri.scheme}://#{uri.host}"
  end
end
