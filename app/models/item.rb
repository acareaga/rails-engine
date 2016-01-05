class Item < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :invoice

  def self.random
    order("RANDOM()").first
  end
end
