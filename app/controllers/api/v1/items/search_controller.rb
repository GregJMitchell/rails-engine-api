class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.search_all(params[:name])
    render json: ItemSerializer.new(items).serializable_hash.to_json
  end

  def show
    item = Item.search_one(params[:name])
    render json: ItemSerializer.new(item).serializable_hash.to_json
  end
end
