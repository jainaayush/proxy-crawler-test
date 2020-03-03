require 'rails_helper'

RSpec.describe "Crawls", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/crawl/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/crawl/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /scrap" do
    it "returns http success" do
      post "/crawl/scrap"
      expect(response).to have_http_status 302
    end
  end

end
