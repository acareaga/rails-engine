class Item < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :invoice
  belongs_to :invoice_items

  def self.random
    order("RANDOM()").first
  end
end
