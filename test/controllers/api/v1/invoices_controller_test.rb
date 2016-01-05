require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase

  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of invoices' do
    get :index, format: :json
    assert_equal Invoice.count, json_response.count
  end

  test '#show responds to json' do
    get :show, format: :json, id: Invoice.last.id
    assert_response :success
  end

  test '#show returns a single record' do
    get :show, format: :json, id: Invoice.last.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct invoice' do
    get :show, format: :json, id: Invoice.last.id
    assert_equal Invoice.last.id, json_response["id"]
  end

  test '#find responds to json' do
    get :find, format: :json, id: Invoice.last.id
    assert_response :success
  end

  test '#find returns a single record' do
    get :find, format: :json, id: Invoice.last.id
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct invoice' do
    get :find, format: :json, id: Invoice.first.id
    assert_equal Invoice.first.id, json_response["id"]
  end

  test '#find_all responds to json' do
    get :find_all, format: :json, id: Invoice.last.id
    assert_response :success
  end

  test '#find_all returns all matching records' do
    get :find_all, format: :json, id: Invoice.first.id
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    get :random, format: :json
    assert_response :success
  end
end
