Rails.application.routes.draw do
  resources :security_transactions
  resources :cash_transactions
  resources :close_prices
  resources :securities
  resources :funds

  get "/fund_balance/:id/:date", to: "fund_balance#index"
  get "/portfolios/:id/:date", to: "portfolios#index"
  get "/pl/:id/:date", to: "pl#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
