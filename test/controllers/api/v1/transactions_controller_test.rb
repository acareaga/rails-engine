require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:transaction)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of transction records' do
    create(:transaction)
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of transactions' do
    transactions = create_list(:transaction, 10)
    get :index, format: :json
    assert_equal transactions.count, json_response.count
  end

  test '#show responds to json' do
    transaction = create(:transaction)
    get :show, format: :json, id: transaction.id
    assert_response :success
  end

  test '#show returns a single record' do
    transaction = create(:transaction)
    get :show, format: :json, id: transaction.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct transaction' do
    transaction = create(:transaction)
    get :show, format: :json, id: transaction.id
    assert_equal transaction.id, json_response["id"]
  end

  test '#find responds to json' do
    transaction = create(:transaction)
    get :find, format: :json, id: transaction.id
    assert_response :success
  end

  test '#find returns a single record' do
    transaction = create(:transaction)
    get :find, format: :json, id: transaction.id
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct transaction' do
    transaction = create(:transaction)
    get :find, format: :json, id: transaction.id
    assert_equal transaction.id, json_response["id"]
  end

  test '#find_all responds to json' do
    transaction = create(:transaction)
    get :find_all, format: :json, id: transaction.id
    assert_response :success
  end

  test '#find_all returns all matching records' do
    transaction = create(:transaction)
    get :find_all, format: :json, id: transaction.id
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    create(:transaction)
    get :random, format: :json
    assert_response :success
  end

  test '#invoice responds to json' do
    transaction = create(:transaction)
    get :invoice, format: :json, id: transaction.id
    assert_response :success
  end
end
