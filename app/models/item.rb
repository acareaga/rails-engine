class Item < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :invoice
  has_many :invoice_items
  before_save :format_currency

  def self.random
    order("RANDOM()").first
  end

  private

  def format_currency
    self.unit_price = unit_price/100.00
  end
end
