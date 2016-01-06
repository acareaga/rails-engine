require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  test '#index responds to json' do
    create(:customer)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns all relevant customer records' do
    create_list(:customer, 10)
    get :index, format: :json
    assert_equal 10, json_response.count
  end

  test '#index returns the correct number of customers' do
    customers = create_list(:customer, 2)
    get :index, format: :json
    assert_equal customers.count, json_response.count
  end

  test '#show responds to json' do
    customer = create(:customer)
    get :show, format: :json, id: customer.id
    assert_response :success
  end

  test '#show returns a single record' do
    customer = create(:customer)
    get :show, format: :json, id: customer.id
    assert_kind_of Hash, json_response
  end

  test '#show returns the correct customer' do
    customer = create(:customer)
    get :show, format: :json, id: customer.id
    assert_equal customer.id, json_response["id"]
  end

  test '#find responds to json' do
    customer = create(:customer)
    get :find, format: :json, first_name: customer.first_name
    assert_response :success
  end

  test '#find returns a single record' do
    customer = create(:customer)
    get :find, format: :json, first_name: customer.first_name
    assert_kind_of Hash, json_response
    assert_equal customer.id, json_response["id"]
  end

  test '#find returns the correct customer' do
    customer = create(:customer)
    get :find, format: :json, id: customer.id
    assert_equal customer.id, json_response["id"]
  end

  test '#find_all responds to json' do
    customer = create(:customer)
    get :find_all, format: :json, first_name: customer.first_name
    assert_response :success
  end

  test '#find_all returns all matching records' do
    customer = create(:customer)
    get :find_all, format: :json, first_name: customer.first_name
    assert_equal customer.id, json_response.first["id"]
    assert_equal 1, json_response.count
  end

  test '#random responds to json' do
    create(:customer)
    get :random, format: :json
    assert_response :success
  end

  test '#invoices responds to json' do
    customer = create(:customer)
    get :invoices, format: :json, id: customer.id
    assert_response :success
  end

  test '#invoices returns specific customer records' do
    customer = create(:customer)
    create(:invoice, customer: customer)
    create(:invoice, customer: customer)
    get :invoices, format: :json, id: customer.id
    assert_equal customer.id, json_response.first["customer_id"]
    assert_equal 2, json_response.count
  end

  test '#transactions responds to json' do
    customer = create(:customer)
    get :transactions, format: :json, id: customer.id
    assert_response :success
  end

  test '#transactions returns specific customer records' do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    transaction = create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice)
    get :transactions, format: :json, id: customer.id
    assert_equal customer.id, Invoice.find(json_response.last["invoice_id"]).customer_id
    assert_equal 3, json_response.count
  end

  ########### BI LOGIC

  test '#favorite_merchant responds to json' do
    skip
    customer = create(:customer)
    customer_2 = create(:customer, name: "Edgar")
    merchant_1 = merchant.create
    merchant_2 = merchant.create(name: "Slota Chips")
    merchant_3 = merchant.create(name: "Jhun's Beats")
    merchant_1.invoices.create(customer: customer, status: "success")
    merchant_1.invoices.create(customer: customer, status: "failure")
    merchant_1.invoices.create(customer: customer, status: "failure")
    merchant_2.invoices.create(customer: customer, status: "success")
    merchant_2.invoices.create(customer: customer, status: "success")
    merchant_2.invoices.create(customer: customer, status: "failure")
    merchant_3.invoices.create(customer: customer_2, status: "success")
    merchant_3.invoices.create(customer: customer_2, status: "failure")
    get :favorite_merchant, format: :json, id: customer.id
  end
end
