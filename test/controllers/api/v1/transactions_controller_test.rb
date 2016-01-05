require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test '#index returns all transactions' do
    get :index, format: :json
    assert_response :success
  end

  test '#show returns a specific transaction by id' do
    get :show, format: :json, id: 100
    assert_response :success
  end
end
