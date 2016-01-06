class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    if params["name"]
      respond_with Merchant.where("#{params.first.first} ILIKE ?", params.first.last).first
    else
      respond_with Merchant.find_by(params.first.first => params.first.last)
    end
  end

  def find_all
    if params["name"]
      respond_with Merchant.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Merchant.where("#{params.first.first}": params.first.last)
    end
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with Merchant.find_by(id: params[:id]).items
  end

  def invoices
    respond_with Merchant.find_by(id: params[:id]).invoices
  end

  def most_revenue
    Merchant.all
    # respond_with Merchant.joins(invoices: :invoice_items).group("merchants.id").sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
