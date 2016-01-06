FactoryGirl.define do
  factory :merchant do
    name "Apple Computers"
  end

  factory :customer do
    first_name "Steve"
    last_name "Jobs"
  end

  factory :item do
    name "Macbook Air"
    description "Best laptop description."
    unit_price 1750.00
    merchant
  end

  factory :transaction do
    invoice
    credit_card_number "123123121123123123"
    result "success"
  end

  factory :invoice do
    customer
    merchant
    status "shipped"
  end

  factory :invoice_item do
    item
    invoice
    quantity 5
    unit_price 1750.00
  end
end
