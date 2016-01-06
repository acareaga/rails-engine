class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    if params["first_name"] || params["last_name"]
      respond_with Customer.where("#{params.first.first} ILIKE ?", params.first.last).first
    else
      respond_with Customer.find_by(params.first.first => params.first.last)
    end
  end

  def find_all
    if params["first_name"] || params["last_name"]
      respond_with Customer.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Customer.where("#{params.first.first}": params.first.last)
    end
  end

  def random
    respond_with Customer.random
  end

  def invoices
    respond_with Customer.find_by(id: params[:id]).invoices
  end

  def transactions
    respond_with Customer.find_by(id: params[:id]).transactions
  end

  def favorite_merchant
    invoice_ids = Customer.find(params[:id]).transactions.where(result: "success").pluck(:invoice_id)
    merchant_ids = Invoice.find(invoice_ids).map { |invoice| invoice.merchant_id }
    sales = merchant_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    top_merchant = merchant_ids.max_by { |v| sales[v] }
    respond_with Merchant.find(top_merchant)
  end
end
