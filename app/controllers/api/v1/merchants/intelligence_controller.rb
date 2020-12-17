class Api::V1::Merchants::IntelligenceController < ApplicationController
  def most_revenue
    merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash.to_json
  end

  def most_items
    merchants = Merchant.most_items(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash.to_json
  end
end
