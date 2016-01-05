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

  # test '#find returns an item by specific case-insensitive name' do
  #   get :find, format: :json, name: "QuI EsSE"
  #   assert_response :success
  # end
  #
  # test '#find returns an item by specific case-insensitive description' do
  #   get :find, format: :json, description: "NoStrum eSSe seQUi"
  #   assert_response :success
  # end

  # test '#find returns a customer by specific id' do
  #   get :find, format: :json, 'id': 54
  #   assert_response :success
  # end
end
