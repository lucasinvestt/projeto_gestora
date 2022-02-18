class PortfoliosController < ApplicationController
    def index
        render json: SecurityTransaction.portfolio(params[:id], Date.parse(params[:date]))
    end
end


