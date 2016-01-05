require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of customers' do
    get :index, format: :json
    assert_equal Customer.count, json_response.count
  end

  test '#index contains items that have the correct properties' do
    get :index, format: :json

    json_response.each do |item|
      assert item["first_name"]
      assert item["last_name"]
    end
  end

  test '#show responds to json' do
    get :show, format: :json, id: Customer.last.id
    assert_response :success
  end

  test '#show returns a single record' do
    get :show, format: :json, id: Customer.last.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct item' do
    get :show, format: :json, id: Customer.last.id
    assert_equal Customer.last.id, json_response["id"]
  end

  test '#find responds to json' do
    get :find, format: :json, first_name: Customer.last.first_name
    assert_response :success
  end

  test '#find returns a single record' do
    get :find, format: :json, first_name: Customer.last.first_name
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct item' do
    get :find, format: :json, id: Customer.first.id
    assert_equal Customer.first.id, json_response["id"]
  end

  test '#find_all responds to json' do
    get :find_all, format: :json, first_name: Customer.last.first_name
    assert_response :success
  end

  test '#find_all returns all matching records' do
    get :find_all, format: :json, first_name: Customer.last.first_name
    assert_equal 2, json_response.count
  end

  ##### WHAT ABOUT RANDOM??

  test '#invoices responds to json' do
    get :invoices, format: :json, id: Customer.last.id
    assert_response :success
  end

  test '#invoices returns a specific customers records' do
    get :invoices, format: :json, id: Customer.first.id
    binding.pry
    assert_equal 1, json_response.count
  end

end
