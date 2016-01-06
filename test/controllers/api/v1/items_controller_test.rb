require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:item)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    create(:item)
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    items = create_list(:item, 5)
    get :index, format: :json
    assert_equal items.count, json_response.count
  end

  test '#show responds to json' do
    item = create(:item)
    get :show, format: :json, id: item.id
    assert_response :success
  end

  test '#show returns a single record' do
    item = create(:item)
    get :show, format: :json, id: item.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct item' do
    item = create(:item)
    get :show, format: :json, id: item.id
    assert_equal item.id, json_response["id"]
  end

  test '#find responds to json' do
    item = create(:item)
    get :find, format: :json, id: item.id
    assert_response :success
  end

  test '#find returns a single record' do
    item = create(:item)
    get :find, format: :json, id: item.id
    assert_kind_of Hash, json_response
  end

  test '#find returns the correct item' do
    item = create(:item)
    get :find, format: :json, id: item.id
    assert_equal item.id, json_response["id"]
  end

  test '#find_all responds to json' do
    item = create(:item)
    get :find_all, format: :json, id: item.id
    assert_response :success
  end

  test '#find_all returns all matching records' do
    item = create(:item)
    get :find_all, format: :json, id: item.id
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    create(:item)
    get :random, format: :json
    assert_response :success
  end

  test '#invoice_items responds to json' do
    item = create(:item)
    get :invoice_items, format: :json, id: item.id
    assert_response :success
  end

  test '#merchant responds to json' do
    item = create(:item)
    get :merchant, format: :json, id: item.id
    assert_response :success
  end
end
