class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(merchant_params)
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with Merchant.find_by(merchant_params).items
  end

  def invoices
    respond_with Merchant.find_by(merchant_params).invoices
  end

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  def revenue
    respond_with Merchant.revenue(params[:id])
  end

  def customers_with_pending_invoices
    respond_with Merchant.customers_with_pending_invoices(params[:id])
  end

  def favorite_customer
    respond_with Merchant.favorite_customer(params[:id])
  end

  private

  def merchant_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
