class PlController < ApplicationController
    def index
        render json: Fund.getFundPL(params[:id], Date.parse(params[:date]))
    end
end


