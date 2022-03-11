Rails.application.routes.draw do
  resources :security_transactions
  resources :cash_transactions
  resources :close_prices
  resources :securities
  resources :funds do
    get "/securities_transactions/:date", to: "funds#getSecuritiesTransactionsFromDate"
    get "/cash_transactions/:date", to: "funds#getCashTransactionsFromDate"
    get "/portfolio_with_close_prices/:date", to: "funds#getPortfolioWithClosePrices"
  end

  get "/fund_balance/:id/:date", to: "fund_balance#index"
  get "/portfolios/:id/:date", to: "portfolios#index"
  get "/pl/:id/:date", to: "pl#index"


  get "/cash_transactions/all/:date", to: "cash_transactions#getAllCashTransactionsFromDate"
  get "/security_transactions/all/:date", to: "security_transactions#getTransactionsFromDate"
  get "/close_prices/all/:date", to: "close_prices#closePricesFromDate"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
