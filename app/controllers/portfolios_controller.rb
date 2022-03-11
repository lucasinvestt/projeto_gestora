class PortfoliosController < ApplicationController
    def index
        render json: SecurityTransaction.portfolio(params[:id], Date.parse(params[:date]))
            .as_json({
                only: [:totalamount],
                include: {
                    security: {
                    only: [:id, :name, :security_type, :isin]
                    }
                }
            })
    end
end


