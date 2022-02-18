class FundBalanceController < ApplicationController
    def index
        render json: CashTransaction.fund_balance(params[:id], Date.parse(params[:date]))
    end
end