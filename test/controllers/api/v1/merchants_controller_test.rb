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

######## BI LOGIC

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

    assert_equal 175, json_response
  end

  test '#most_revenue responds to json' do
    skip
    merchant = create(:merchant)
    item     = create(:item, merchant: merchant)
    item2    = create(:item, merchant: merchant)
    invoice  = create(:invoice, merchant: merchant)
    create(:invoice_item, item: item, invoice: invoice, unit_price: 100, quantity: 1)
    create(:invoice_item, item: item2, invoice: invoice, unit_price: 100, quantity: 1)

    merchant_adam = create(:merchant, name: "Adam's Store")
    item     = create(:item, merchant: merchant)
    item2    = create(:item, merchant: merchant)
    invoice  = create(:invoice, merchant: merchant)
    create(:invoice_item, item: item, invoice: invoice, unit_price: 200, quantity: 1)
    create(:invoice_item, item: item2, invoice: invoice, unit_price: 600, quantity: 2)

    merchant_elliot = create(:merchant, name: "Elliot's Store")
    item     = create(:item, merchant: merchant)
    item2    = create(:item, merchant: merchant)
    invoice  = create(:invoice, merchant: merchant)
    create(:invoice_item, item: item, invoice: invoice, unit_price: 200, quantity: 1)
    create(:invoice_item, item: item2, invoice: invoice, unit_price: 800, quantity: 1)

    get :most_revenue, format: :json, quantity: 2
    assert_equal 2, json_response.count
    assert_equal [merchant_adam.id, merchant_elliot.id], json_response.map { |response| response["id"] }
  end
end
