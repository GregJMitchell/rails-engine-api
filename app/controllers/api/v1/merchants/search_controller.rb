class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Merchant.search_all(params[:name])
    render json: MerchantSerializer.new(merchants).serializable_hash.to_json
  end

  def show
    merchant = Merchant.search_one(params[:name])
    render json: MerchantSerializer.new(merchant).serializable_hash.to_json
  end
end
