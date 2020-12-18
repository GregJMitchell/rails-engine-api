class Api::V1::Merchants::IntelligenceController < ApplicationController
  def most_revenue
    merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash.to_json
  end

  def most_items
    merchants = Merchant.most_items(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash.to_json
  end

  def revenue_between_dates
    revenue = Invoice.revenue(params[:start], params[:end])[0]
    render json: RevenueSerializer.new(revenue).serializable_hash.to_json
  end

  def revenue
    merchant = Merchant.find(params[:id])
    revenue = merchant.revenue
    render json: RevenueSerializer.new(revenue[0]).serializable_hash.to_json
  end
end
