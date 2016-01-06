require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:merchant)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    create(:merchant)
    get :index, format: :json
    assert_kind_of Array, json_response
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

  test '#show returns a single record' do
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

  test '#invoices responds to json' do
    merchant = create(:merchant)
    get :invoices, format: :json, id: merchant.id
    assert_response :success
  end

# FactoryGirl.create(:merchant, name: "Edgar's Store")
 #### NEED TO FIX WITH FACTORY ABOVE

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
