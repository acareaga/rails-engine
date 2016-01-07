class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(transaction_params)
  end

  def find
    respond_with Transaction.find_by(transaction_params)
    # if params["credit_card_number"] || params["result"]
    #   respond_with Transaction.where("#{params.first.first} ILIKE ?", params.first.last).first
    # else
    #   respond_with Transaction.find_by(params.first.first => params.first.last)
    # end
  end

  def find_all
    respond_with Transaction.where(transaction_params)
    # if params["credit_card_number"] || params["result"]
    #   respond_with Transaction.where("#{params.first.first} ILIKE ?", params.first.last)
    # else
    #   respond_with Transaction.where("#{params.first.first}": params.first.last)
    # end
  end

  def random
    respond_with Transaction.random
  end

  def invoice
    respond_with Transaction.find_by(transaction_params).invoice
  end

  private

  def transaction_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end
end
