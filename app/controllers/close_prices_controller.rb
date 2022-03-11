class ClosePricesController < ApplicationController
  before_action :set_close_price, only: %i[ show update destroy ]

  # GET /close_prices
  def index
    @close_prices = ClosePrice.all

    render json: @close_prices, include: {security: {only: [:symbol]}}
  end

  # GET /close_prices/1
  def show
    render json: @close_price, include: {security: {only: [:id, :symbol]}}
  end

  # POST /close_prices
  def create
    @close_price = ClosePrice.new(close_price_params)

    if @close_price.save
      render json: @close_price, status: :created, location: @close_price
    else
      render json: @close_price.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /close_prices/1
  def update
    if @close_price.update(close_price_params)
      render json: @close_price
    else
      render json: @close_price.errors, status: :unprocessable_entity
    end
  end

  # DELETE /close_prices/1
  def destroy
    @close_price.destroy
  end

  def closePricesFromDate
    render json: ClosePrice.all.where("date = ?", date), include: {security: {only: [:symbol]}}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_close_price
      @close_price = ClosePrice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def close_price_params
      params.require(:close_price).permit(:date, :value, :security_id)
    end

  protected
    def date
      Date.parse(params[:date])
    end
end
