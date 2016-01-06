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
    Merchant.all
    # respond_with Merchant.joins(invoices: :invoice_items).group("merchants.id").sum("invoice_items.quantity * invoice_items.unit_price")
  end

  ######### SINGLE MERCHANT

  def revenue
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    revenue = InvoiceItem.where(invoice_id: paid_invoice_ids).sum("unit_price * quantity")
    respond_with({"revenue" => revenue })
  end

  ########## START HERE

  def favorite_customer
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    customer_ids = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    sales = customer_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    top_customer = customer_ids.max_by { |v| sales[v] }
    respond_with Customer.find(top_customer)
  end
end

# respond_with Invoice.where(merchant_id: params[:id]).joins(:invoice_items).sum("invoice_items.quantity * invoice_items.unit_price")

# invoices.successful. #grouping by merchant_id
# Merchant.find_by_sql("Select * from invoices WHERE customers.id = customer")

# Customer.find_by(id: params[:id]).transactions
# respond_with Merchant.joins(:invoices).where(invoices: { customer: customer, status: "shipped" }).group(:id).group("invoice_count desc")
