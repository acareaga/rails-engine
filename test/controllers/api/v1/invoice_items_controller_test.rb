require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:invoice_item)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns the correct number of invoice items' do
    invoice_items = create_list(:invoice_item, 2)
    get :index, format: :json
    assert_equal invoice_items.count, json_response.count
  end

  test '#show responds to json' do
    invoice_item = create(:invoice_item)
    get :show, format: :json, id: invoice_item.id
    assert_response :success
  end

  test '#show returns a single record' do
    invoice_item = create(:invoice_item)
    get :show, format: :json, id: invoice_item.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct invoice item' do
    invoice_item = create(:invoice_item)
    get :show, format: :json, id: invoice_item.id
    assert_equal invoice_item.id, json_response["id"]
  end

  test '#find responds to json' do
    invoice_item = create(:invoice_item)
    get :find, format: :json, id: invoice_item.id
    assert_response :success
  end

  test '#find returns a hash of the correct record' do
    invoice_item = create(:invoice_item)
    get :find, format: :json, id: invoice_item.id
    assert_kind_of Hash, json_response
    assert_equal invoice_item.id, json_response["id"]
  end

  test '#find_all responds to json' do
    invoice_item = create(:invoice_item)
    get :find_all, format: :json, id: invoice_item.id
    assert_response :success
  end

  test '#find_all returns all matching invoice item records' do
    invoice_items = create_list(:invoice_item, 10)
    get :find_all, format: :json, id: invoice_items.first.id
    assert_equal invoice_items.first["id"], json_response.first["id"]
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    create(:invoice_item)
    get :random, format: :json
    assert_response :success
  end

  test '#invoice responds to json' do
    invoice_item = create(:invoice_item)
    get :invoice, format: :json, id: invoice_item.id
    assert_response :success
  end

  test '#invoice returns the relevant record based on the invoice item' do
    invoice_item = create(:invoice_item)
    get :invoice, format: :json, id: invoice_item.id
    assert_equal invoice_item.invoice_id, json_response["id"]
  end

  test '#item responds to json' do
    invoice_item = create(:invoice_item)
    get :item, format: :json, id: invoice_item.id
    assert_response :success
  end

  test '#item returns the correct record based on the invoice item' do
    invoice_item = create(:invoice_item)
    get :item, format: :json, id: invoice_item.id
    assert_equal invoice_item.item_id, json_response["id"]
  end
end
