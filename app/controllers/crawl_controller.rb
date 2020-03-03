require 'scrap_twitter'

class CrawlController < ApplicationController
  def index
    @profile = params.except('controller', 'action').as_json
  end

  def new; end

  def scrap
    response = ScrapTwitter.new(scrap_params).scrap_profile
    redirect_to crawl_index_path(response.as_json)
  end

  private
    def scrap_params
      params.permit(:crawl_url, :crawl_token)
    end
end
