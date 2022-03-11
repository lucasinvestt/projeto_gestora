class PlController < ApplicationController
    def index
        render json: Fund.getFundPL(id, date)
    end

    protected
    def id 
        params[:id]
    end

    def date
        Date.parse(params[:date])
    end
end


