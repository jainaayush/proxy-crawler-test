require 'net/http'
require 'json'

class ScrapTwitter
  attr_reader :crawl_url, :crawl_token

  def initialize(args)
    @crawl_url = args[:crawl_url]
    @crawl_token = args[:crawl_token]
  end

  def scrap_profile
    uri = URI('https://api.proxycrawl.com')
    uri.query = URI.encode_www_form({
                                      token: crawl_token,
                                      format: 'json',
                                      url: crawl_url
                                    })
    response = Net::HTTP.get_response(uri)
    parsing_profile(response)
  end

  private

  def parsing_profile(res)
    json = JSON.parse(res.body)
    parsed_data = Nokogiri::HTML.parse(json['body'])
    twitter_profile_data(parsed_data)
  end

  def twitter_profile_data(parsed_data)
    data = {
      name: parsed_data.css('.ProfileHeaderCard-nameLink').text,
      bio_card: parsed_data.css('.ProfileHeaderCard-bio').text,
      join_date: parsed_data.css('.ProfileHeaderCard-joinDateText').text,
      handle: parsed_data.css('.ProfileHeaderCard-screennameLink span').text
    }
    parsed_data.css('.ProfileNav-list .ProfileNav-stat').each do |d|
      key = d.attributes['data-nav']&.value
      data[key&.to_sym] = d.attributes['title']&.value
    end
    save_data(data)
    data
  end

  def save_data(profile_data)
    File.open("public/#{profile_data[:name].parameterize}-twitter.json", 'w') do |f|
      f.write(profile_data.compact)
    end
  end
end
