require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:item)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    create(:item)
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    items = create_list(:item, 5)
    get :index, format: :json
    assert_equal items.count, json_response.count
  end

  test '#show responds to json' do
    item = create(:item)
    get :show, format: :json, id: item.id
    assert_response :success
  end

  test '#show returns a single record' do
    item = create(:item)
    get :show, format: :json, id: item.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct item' do
    item = create(:item)
    get :show, format: :json, id: item.id
    assert_equal item.id, json_response["id"]
  end

  test '#find responds to json' do
    item = create(:item)
    get :find, format: :json, id: item.id
    assert_response :success
  end

  test '#find returns a single record' do
    item = create(:item)
    get :find, format: :json, id: item.id
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct item' do
    item = create(:item)
    get :find, format: :json, id: item.id
    assert_equal item.id, json_response["id"]
  end

  test '#find_all responds to json' do
    item = create(:item)
    get :find_all, format: :json, id: item.id
    assert_response :success
  end

  test '#find_all returns all matching item records' do
    item = create(:item)
    get :find_all, format: :json, id: item.id
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    create(:item)
    get :random, format: :json
    assert_response :success
  end

  test '#invoice_items responds to json' do
    item = create(:item)
    get :invoice_items, format: :json, id: item.id
    assert_response :success
  end

  test '#invoice_items returns the relevant data based on an item' do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)
    get :invoice_items, format: :json, id: item.id
    assert_equal item.id, json_response.first["item_id"]
  end

  test '#merchant responds to json' do
    item = create(:item)
    get :merchant, format: :json, id: item.id
    assert_response :success
  end

  test '#merchant returns the correct record based on on an item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    get :merchant, format: :json, id: item.id
    assert_equal item.merchant_id, json_response["id"]
  end

  test '#most_revenue responds to json and returns the correct item data' do
    item = create(:item)
    item_2 = create(:item, name: "Cookies", unit_price: 50)
    item_3 = create(:item, name: "iPhone", unit_price: 100)
    invoice_item = create(:invoice_item, item: item, quantity: 10)
    invoice_item_2 = create(:invoice_item, item: item_2, quantity: 40)
    invoice_item_3 = create(:invoice_item, item: item_3, quantity: 500)

    item_4 = create(:item)
    item_5 = create(:item, name: "Laptop", unit_price: 500)
    item_6 = create(:item, name: "Desk", unit_price: 40)
    invoice_item_4 = create(:invoice_item, item: item_4, quantity: 1)
    invoice_item_5 = create(:invoice_item, item: item_5, quantity: 1)
    invoice_item_6 = create(:invoice_item, item: item_6, quantity: 1)

    get :most_revenue, format: :json, quantity: 2
    assert_equal 2, json_response.count
    assert item_3.name, json_response.first["name"]
  end

  test '#most_items responds to json and returns the correct item data' do
    item = create(:item)
    item_2 = create(:item, name: "Vodka", unit_price: 50)
    item_3 = create(:item, name: "Whiskey", unit_price: 100)
    invoice_item = create(:invoice_item, item: item, quantity: 10)
    invoice_item_2 = create(:invoice_item, item: item_2, quantity: 40)
    invoice_item_3 = create(:invoice_item, item: item_3, quantity: 500)

    item_4 = create(:item)
    item_5 = create(:item, name: "Gin", unit_price: 500)
    item_6 = create(:item, name: "Rum", unit_price: 40)
    invoice_item_4 = create(:invoice_item, item: item_4, quantity: 1)
    invoice_item_5 = create(:invoice_item, item: item_5, quantity: 1)
    invoice_item_6 = create(:invoice_item, item: item_6, quantity: 1)

    get :most_items, format: :json, quantity: 2
    assert_equal 2, json_response.count
    assert item_3.name, json_response.first["name"]
  end
end
