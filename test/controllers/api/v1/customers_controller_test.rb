require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test '#index returns all customers' do
    get :index, format: :json
    assert_response :success
  end

  test '#show returns a specific customer by id' do
    get :show, format: :json, id: 10
    assert_response :success
  end

  test '#find returns a customer by specific case-insensitive first name' do
    get :find, format: :json, first_name: "sHaWn"
    assert_response :success
  end

  test '#find returns a customer by specific case-insensitive first name' do
    get :find, format: :json, last_name: "sHaWn"
    assert_response :success
  end

  # test '#find returns a customer by specific id' do
  #   get :find, format: :json, 'id': 54
  #   assert_response :success
  # end
end
