require 'rails_helper'

RSpec.describe CrawlController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #scrap' do
    it 'returns a success response' do
      post :scrap, params: { crawl_url: 'https://twitter.com/realDonaldTrump', crawl_token: 'Q83hrXsMBj1URbwRWBF50g' }
      expect(response).to have_http_status(302)
    end
  end
end
