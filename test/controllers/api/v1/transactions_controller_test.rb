require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of transactions' do
    get :index, format: :json
    assert_equal Transaction.count, json_response.count
  end

  test '#show responds to json' do
    get :show, format: :json, id: Transaction.last.id
    assert_response :success
  end

  test '#show returns a single record' do
    get :show, format: :json, id: Transaction.last.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct transaction' do
    get :show, format: :json, id: Transaction.last.id
    assert_equal Transaction.last.id, json_response["id"]
  end

  test '#find responds to json' do
    get :find, format: :json, id: Transaction.last.id
    assert_response :success
  end

  test '#find returns a single record' do
    get :find, format: :json, id: Transaction.last.id
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct transaction' do
    get :find, format: :json, id: Transaction.first.id
    assert_equal Transaction.first.id, json_response["id"]
  end

  test '#find_all responds to json' do
    get :find_all, format: :json, id: Transaction.last.id
    assert_response :success
  end

  test '#find_all returns all matching records' do
    get :find_all, format: :json, id: Transaction.first.id
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    get :random, format: :json
    assert_response :success
  end
end
