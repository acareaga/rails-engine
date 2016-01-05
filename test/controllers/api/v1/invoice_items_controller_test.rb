require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test '#index returns all invoice items' do
    get :index, format: :json
    assert_response :success
  end

  test '#show returns a specific invoice item by id' do
    get :show, format: :json, id: 55
    assert_response :success
  end
end
