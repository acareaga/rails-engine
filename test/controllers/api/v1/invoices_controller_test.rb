require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:invoice)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    create(:invoice)
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of invoices' do
    invoices = create_list(:invoice, 5)
    get :index, format: :json
    assert_equal invoices.count, json_response.count
  end

  test '#show responds to json' do
    invoice = create(:invoice)
    get :show, format: :json, id: invoice.id
    assert_response :success
  end

  test '#show returns a single record' do
    invoice = create(:invoice)
    get :show, format: :json, id: invoice.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct invoice' do
    invoice = create(:invoice)
    get :show, format: :json, id: invoice.id
    assert_equal invoice.id, json_response["id"]
  end

  test '#find responds to json' do
    invoice = create(:invoice)
    get :find, format: :json, id: invoice.id
    assert_response :success
  end

  test '#find returns a single record' do
    invoice = create(:invoice)
    get :find, format: :json, id: invoice.id
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct invoice' do
    invoice = create(:invoice)
    get :find, format: :json, id: invoice.id
    assert_equal invoice.id, json_response["id"]
  end

  test '#find_all responds to json' do
    invoice = create(:invoice)
    get :find_all, format: :json, id: invoice.id
    assert_response :success
  end

  test '#find_all returns all matching records' do
    invoice = create(:invoice)
    get :find_all, format: :json, id: invoice.id
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    create(:invoice)
    get :random, format: :json
    assert_response :success
  end

  test '#transactions responds to json' do
    invoice = create(:invoice)
    get :transactions, format: :json, id: invoice.id
    assert_response :success
  end

  test '#invoice_items responds to json' do
    invoice = create(:invoice)
    get :invoice_items, format: :json, id: invoice.id
    assert_response :success
  end

  test '#items responds to json' do
    invoice = create(:invoice)
    get :items, format: :json, id: invoice.id
    assert_response :success
  end

  test '#customer responds to json' do
    invoice = create(:invoice)
    get :customer, format: :json, id: invoice.id
    assert_response :success
  end

  test '#merchant responds to json' do
    invoice = create(:invoice)
    get :merchant, format: :json, id: invoice.id
    assert_response :success
  end
end
