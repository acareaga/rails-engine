class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(customer_params)
  end

  def find
    respond_with Customer.find_by(customer_params)
  end

  def find_all
    respond_with Customer.where(customer_params)
  end

  def random
    respond_with Customer.random
  end

  def invoices
    respond_with Customer.find_by(customer_params).invoices
  end

  def transactions
    respond_with Customer.find_by(customer_params).transactions
  end

  def favorite_merchant
    respond_with Customer.favorite_merchant(params[:id])
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :id, :created_at, :updated_at)
  end
end
