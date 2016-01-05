require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  test '#index returns all merchants' do
    get :index, format: :json
    assert_response :success
  end

  test '#show returns a specific merchant by id' do
    get :show, format: :json, id: 1
    assert_response :success
  end
end
