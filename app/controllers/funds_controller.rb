class FundsController < ApplicationController
  before_action :set_fund, only: %i[ show update destroy ]

  # GET /funds
  def index
    @funds = Fund.all

    render json: @funds
  end

  # GET /funds/1
  def show
    render json: @fund
  end

  # POST /funds
  def create
    @fund = Fund.new(fund_params)

    if @fund.save
      render json: @fund, status: :created, location: @fund
    else
      render json: @fund.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /funds/1
  def update
    if @fund.update(fund_params)
      render json: @fund
    else
      render json: @fund.errors, status: :unprocessable_entity
    end
  end

  # DELETE /funds/1
  def destroy
    @fund.destroy
  end

  def getSecuritiesTransactionsFromDate
    render json: SecurityTransaction.securitiesTransactionsFromDate(fund_id, date), 
      include: {
        security: {
          only: [:id, :symbol, :security_type]
        },
        # fund: {
        #   only: [:id, :name]
        # }
      }

  end

  def getCashTransactionsFromDate
      render json: CashTransaction.getCashTransactionsFromDate(fund_id, date)
  end

  def getPortfolioWithClosePrices
      # render json: Fund.getPortfolioWithClosePrices(fund_id, date) 
      render json: Fund.getPortfolioWithClosePrices(fund_id, date),
        include: {
          security: {
            only: [:id, :symbol, :security_type]
          },
        }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fund
      @fund = Fund.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fund_params
      params.require(:fund).permit(:name, :date)
    end

  protected
  def fund_id 
      params[:fund_id]
  end

  def date
      Date.parse(params[:date])
  end

end
