require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test '#index returns all items' do
    get :index, format: :json
    assert_response :success
  end

  test '#show returns a specific item by id' do
    get :show, format: :json, id: 25
    assert_response :success
  end
end
