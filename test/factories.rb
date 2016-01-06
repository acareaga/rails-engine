FactoryGirl.define do
  factory :merchant do
    name "Apple"
  end

  factory :customer do
    first_name "John"
    last_name "Doe"
  end

  factory :item do
    name "Macbook Air"
    description "Best laptop description."
    unit_price 1500.00
    merchant
  end

  factory :transaction do
    invoice
    credit_card_number "123123121123123123"
    result "Success"
  end

  factory :invoice do
    customer
    merchant
    status "Success"
  end

  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 1500.00
  end
end
