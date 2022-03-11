class SecuritiesController < ApplicationController
  before_action :set_security, only: %i[ show update destroy ]

  # GET /securities
  def index
    @securities = Security.all

    render json: @securities
  end

  # GET /securities/1
  def show
    render json: @security
  end

  # POST /securities
  def create
    @security = Security.new(security_params)

    if @security.save
      render json: @security, status: :created, location: @security
    else
      render json: @security.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /securities/1
  def update
    if @security.update(security_params)
      render json: @security
    else
      render json: @security.errors, status: :unprocessable_entity
    end
  end

  # DELETE /securities/1
  def destroy
    @security.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security
      @security = Security.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def security_params
      params.require(:security).permit(:name, :security_type, :isin, :symbol)
    end
end
