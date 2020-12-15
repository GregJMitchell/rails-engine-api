require 'rails_helper'

describe 'Items Merchant API' do
  it 'Can get the Merchant for a item' do
    merchant = create :merchant
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchants"

    expected_id = merchant.id.to_s

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq(expected_id)
  end
end