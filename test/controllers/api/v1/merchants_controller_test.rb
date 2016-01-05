require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of merchants' do
    get :index, format: :json
    assert_equal Merchant.count, json_response.count
  end

  test '#show responds to json' do
    get :show, format: :json, id: Merchant.last.id
    assert_response :success
  end

  test '#show returns a single record' do
    get :show, format: :json, id: Merchant.last.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct merchant' do
    get :show, format: :json, id: Merchant.last.id
    assert_equal Merchant.last.id, json_response["id"]
  end

  test '#find responds to json' do
    get :find, format: :json, id: Merchant.last.id
    assert_response :success
  end

  test '#find returns a single record' do
    get :find, format: :json, id: Merchant.last.id
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct merchant' do
    get :find, format: :json, id: Merchant.first.id
    assert_equal Merchant.first.id, json_response["id"]
  end

  test '#find_all responds to json' do
    get :find_all, format: :json, id: Merchant.last.id
    assert_response :success
  end

  test '#find_all returns all matching records' do
    get :find_all, format: :json, id: Merchant.first.id
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    get :random, format: :json
    assert_response :success
  end
end
