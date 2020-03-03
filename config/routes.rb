Rails.application.routes.draw do

  root to: 'home#index'
  get 'crawl/index', to: 'crawl#index'
  get 'crawl/new', to: 'crawl#new'
  post 'crawl/scrap', to: 'crawl#scrap'
end
