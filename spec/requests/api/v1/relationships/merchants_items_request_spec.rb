require 'rails_helper'

describe 'Merchants Items API' do
  it 'Can get items for a merchant' do
    merchant = create :merchant
    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)
    item4 = create(:item, merchant: merchant)
    items = [item1, item2, item3, item4]

    expected_ids = items.map do |item|
      item.id
    end

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    item_ids = json[:data].map do |item|
      item[:id].to_i
    end

    expect(item_ids.sort).to eq(expected_ids)
  end
end
