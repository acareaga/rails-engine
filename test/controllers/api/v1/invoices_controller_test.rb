require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test '#index returns all invoices' do
    get :index, format: :json
    assert_response :success
  end

  test '#show returns a specific invoice by id' do
    get :show, format: :json, id: 30
    assert_response :success
  end
end
