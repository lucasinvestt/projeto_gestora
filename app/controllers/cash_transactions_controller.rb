class CashTransactionsController < ApplicationController
  before_action :set_cash_transaction, only: %i[ show update destroy ]

  # GET /cash_transactions
  def index
    @cash_transactions = CashTransaction.all

    render json: @cash_transactions
  end

  # GET /cash_transactions/1
  def show
    render json: @cash_transaction
  end

  # POST /cash_transactions
  def create
    @cash_transaction = CashTransaction.new(cash_transaction_params)

    if @cash_transaction.save
      render json: @cash_transaction, status: :created, location: @cash_transaction
    else
      render json: @cash_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cash_transactions/1
  def update
    if @cash_transaction.update(cash_transaction_params)
      render json: @cash_transaction
    else
      render json: @cash_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cash_transactions/1
  def destroy
    @cash_transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash_transaction
      @cash_transaction = CashTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cash_transaction_params
      params.require(:cash_transaction).permit(:description, :date, :value, :funds_id)
    end
end
