class Transaction < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :customer
  
  def self.random
    order("RANDOM()").first
  end
end
