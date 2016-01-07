class Item < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  belongs_to :merchant
  belongs_to :invoice
  has_many :invoice_items
  before_save :format_currency

  def self.random
    order("RANDOM()").first
  end

  def calc_items
    invoice_items.joins(:invoice).sum(:quantity)
  end

  def calc_revenue
    invoice_items.joins(:invoice).sum("unit_price * quantity")
  end

  def self.most_items(quantity)
    all.sort_by(&:calc_items).reverse[0...quantity.to_i]
  end

  def self.most_revenue(quantity)
    all.sort_by(&:calc_revenue).reverse[0...quantity.to_i]
  end

  private

  def format_currency
    self.unit_price = unit_price/100.00
  end
end
