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

  ########## BI LOGIC

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  ######### SINGLE MERCHANT

  def revenue
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    revenue = InvoiceItem.where(invoice_id: paid_invoice_ids).sum("unit_price * quantity")
    respond_with({"revenue" => revenue })
  end

  def customers_with_pending_invoices
    invoices = Merchant.find_by(id: params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoices).where(result: "failed").pluck(:invoice_id)
    customer_ids = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    respond_with Customer.find(customer_ids)
  end

  def favorite_customer
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    customer_ids = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    sales = customer_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    top_customer = customer_ids.max_by { |v| sales[v] }
    respond_with Customer.find(top_customer)
  end
end
