require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:merchant)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns the correct number of merchants' do
    merchants = create_list(:merchant, 2)
    get :index, format: :json
    assert_equal merchants.count, json_response.count
  end

  test '#show responds to json' do
    merchant = create(:merchant)
    get :show, format: :json, id: merchant.id
    assert_response :success
  end

  test '#show returns a single merchant record' do
    merchant = create(:merchant)
    get :show, format: :json, id: merchant.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct merchant' do
    merchant = create(:merchant)
    get :show, format: :json, id: merchant.id
    assert_equal merchant.id, json_response["id"]
  end

  test '#find responds to json' do
    merchant = create(:merchant)
    get :find, format: :json, id: merchant.id
    assert_response :success
  end

  test '#find returns a single record' do
    merchant = create(:merchant)
    get :find, format: :json, id: merchant.id
    assert_equal merchant.id, json_response["id"]
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct merchant' do
    merchant = create(:merchant)
    get :find, format: :json, id: merchant.id
    assert_equal merchant.id, json_response["id"]
  end

  test '#find_all responds to json' do
    merchant = create(:merchant)
    get :find_all, format: :json, id: merchant.id
    assert_response :success
  end

  test '#find_all returns all matching records' do
    merchant = create(:merchant)
    get :find_all, format: :json, id: merchant.id
    assert_equal merchant.id, json_response.first["id"]
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    create(:merchant)
    get :random, format: :json
    assert_response :success
  end

  test '#items responds to json' do
    merchant = create(:merchant)
    get :items, format: :json, id: merchant.id
    assert_response :success
  end

  test '#items returns all relevant merchant item records' do
    merchant = create(:merchant)
    items = create_list(:item, 45, merchant: merchant)
    get :items, format: :json, id: merchant.id
    assert_equal merchant.id, json_response.first["merchant_id"]
    assert_equal 45, json_response.count
  end

  test '#invoices responds to json' do
    merchant = create(:merchant)
    get :invoices, format: :json, id: merchant.id
    assert_response :success
  end

  test '#invoices returns all relevant merchant invoice records' do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 12, merchant: merchant)
    get :invoices, format: :json, id: merchant.id
    assert_equal merchant.id, json_response.first["merchant_id"]
    assert_equal 12, json_response.count
  end

  test '#revenue responds to json' do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    invoice_2 = create(:invoice, merchant: merchant)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice_2)
    get :revenue, format: :json, id: merchant.id
    assert_response :success
  end

  test '#revenue returns the total revenue for a merchant transactions' do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    invoice_2 = create(:invoice, merchant: merchant)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice_2)
    get :revenue, format: :json, id: merchant.id
    assert_kind_of Hash, json_response
  end

  test '#most_revenue responds to json and returns the correct data' do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    invoice_2 = create(:invoice, merchant: merchant)
    invoice_3 = create(:invoice, merchant: merchant)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)

    merchant_2 = create(:merchant, name: "Matt's Cookies")
    invoice_4 = create(:invoice, merchant: merchant_2)
    invoice_5 = create(:invoice, merchant: merchant_2)
    invoice_6 = create(:invoice, merchant: merchant_2)
    create(:transaction, invoice: invoice_4)
    create(:transaction, invoice: invoice_5)
    create(:transaction, invoice: invoice_6)

    get :most_revenue, format: :json, quantity: 2
    assert_equal 2, json_response.count
    assert_equal merchant.name, json_response.first["name"]
  end

  test '#most_items responds to json and returns the correct data' do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    invoice_2 = create(:invoice, merchant: merchant)
    invoice_3 = create(:invoice, merchant: merchant)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)

    merchant_2 = create(:merchant, name: "Matt's Cookies")
    invoice_4 = create(:invoice, merchant: merchant_2)
    invoice_5 = create(:invoice, merchant: merchant_2)
    invoice_6 = create(:invoice, merchant: merchant_2)
    create(:transaction, invoice: invoice_4)
    create(:transaction, invoice: invoice_5)
    create(:transaction, invoice: invoice_6)

    get :most_revenue, format: :json, quantity: 2
    assert_equal 2, json_response.count
    assert_equal merchant.name, json_response.first["name"]
  end

  test '#favorite_customer responds to json' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, invoice: invoice)
    get :favorite_customer, format: :json, id: merchant.id
    assert_response :success
  end

  test '#favorite_customer returns the top merchant based on a customer data' do
    customer = create(:customer)

    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)

    merchant_2 = create(:merchant, name: "Cole")
    invoice_4 = create(:invoice, customer: customer, merchant: merchant_2)
    invoice_5 = create(:invoice, customer: customer, merchant: merchant_2)
    create(:transaction, invoice: invoice_4)
    create(:transaction, invoice: invoice_5)

    get :favorite_customer, format: :json, id: merchant.id
    assert_equal customer.id, json_response["id"]
  end
end
