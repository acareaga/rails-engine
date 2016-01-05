class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def self.random
    order("RANDOM()").first
  end
end
