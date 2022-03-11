class SecurityTransactionsController < ApplicationController
  before_action :set_security_transaction, only: %i[ show update destroy ]

  # GET /security_transactions
  def index
    @security_transactions = SecurityTransaction.all

    render json: @security_transactions, 
      include: {
        security: {
          only: [:id, :symbol, :security_type]
        },
        fund: {
          only: [:id, :name]
        }
      }
  end

  # GET /security_transactions/1
  def show
    render json: @security_transaction,
      include: {
        security: {
          only: [:id, :symbol, :security_type]
        },
        fund: {
          only: [:id, :name]
        }
      }
  end

  # POST /security_transactions
  def create
    @security_transaction = SecurityTransaction.new(security_transaction_params)
  
    # Cria transação de caixa equivalente
    cashTransactionDate = Date.parse(params[:date])
    fund_id = params[:fund_id]
    value = -(params[:amount] * params[:unit_value])
    security_symbol = Security.find(params[:security_id]).symbol

    description = params[:amount] > 0 ? "Compra de #{security_symbol}" : "Venda de #{security_symbol}"

    newCashTransaction = {
      "description": description,
      "date": cashTransactionDate,
      "value": value,
      "fund_id": fund_id
    }
    @cashTransaction = CashTransaction.new(newCashTransaction)

    if @security_transaction.save && @cashTransaction.save
      render json: @security_transaction, status: :created, location: @security_transaction
    else
      render json: @security_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /security_transactions/1
  def update
    if @security_transaction.update(security_transaction_params)
      render json: @security_transaction
    else
      render json: @security_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /security_transactions/1
  def destroy
    @security_transaction.destroy
  end

  def getTransactionsFromDate
    render json: SecurityTransaction.allSecuritiesTransactionsFromDate(params[:date]),
      include: {
        security: {
          only: [:id, :symbol, :security_type]
        },
        fund: {
          only: [:id, :name]
        }
      }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security_transaction
      @security_transaction = SecurityTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def security_transaction_params
      params.require(:security_transaction).permit(:date, :amount, :unit_value, :fund_id, :security_id)
    end
end
