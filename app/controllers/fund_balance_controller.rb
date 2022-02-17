class FundBalanceController < ApplicationController
    def index
        render json: CashTransaction.fund_balance(params[:id])
    end
end