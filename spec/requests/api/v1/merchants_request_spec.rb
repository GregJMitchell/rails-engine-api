require 'rails_helper'

describe 'Merchants API' do
  it 'Sends a single merchant' do
    merchant = create :merchant

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data].count).to eq(4)

    expect(merchant[:data][:attributes]).to have_key(:id)
    expect(merchant[:data][:attributes][:id]).to be_a(Integer)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
