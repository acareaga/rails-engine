class Item < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :invoice
  has_many :invoice_items

  def self.random
    order("RANDOM()").first
  end
end
