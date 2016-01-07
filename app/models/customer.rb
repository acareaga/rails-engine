class Customer < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.random
    order("RANDOM()").first
  end

  def self.favorite_merchant(id)
    invoice_ids  = Customer.find(id).transactions.where(result: "success").pluck(:invoice_id)
    merchant_ids = Invoice.find(invoice_ids).map { |invoice| invoice.merchant_id }
    sales        = merchant_ids.inject(Hash.new(0)) { |merchant, count| merchant[count] += 1; merchant }
    top_merchant = merchant_ids.max_by { |merchant| sales[merchant] }
    Merchant.find(top_merchant)
  end
end
