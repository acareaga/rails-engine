class Merchant < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  has_many :items
  has_many :invoices

  def calc_items
    invoices.successful.joins(:invoice_items).sum(:quantity)
  end

  def calc_revenue
    invoices.successful.joins(:invoice_items).sum("unit_price * quantity")
  end

  def self.random
    order("RANDOM()").first
  end

  def self.revenue(id)
    invoice_ids = Merchant.find(id).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    revenue = InvoiceItem.where(invoice_id: paid_invoice_ids).sum("unit_price * quantity")
    {"revenue" => revenue }
  end

  def self.most_items(quantity)
    all.sort_by(&:calc_items).reverse[0...quantity.to_i]
  end

  def self.most_revenue(quantity)
    all.sort_by(&:calc_revenue).reverse[0...quantity.to_i]
  end

  def self.customers_with_pending_invoices(id)
    invoices = Merchant.find_by(id: id).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoices).where(result: "failed").pluck(:invoice_id)
    customer_ids = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    Customer.find(customer_ids)
  end

  def self.favorite_customer(id)
    invoice_ids = Merchant.find(id).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    customer_ids = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    sales = customer_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    top_customer = customer_ids.max_by { |v| sales[v] }
    Customer.find(top_customer)
  end
end
