require 'rails_helper'

describe 'Merchants API' do
  it 'Sends a single merchant' do
    merchant = create :merchant
    create_list(:item, 4, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data].count).to eq(4)

    expect(merchant[:data][:attributes]).to have_key(:id)
    expect(merchant[:data][:attributes][:id]).to be_a(Integer)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:created_at)
    expect(merchant[:data][:attributes][:created_at]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:updated_at)
    expect(merchant[:data][:attributes][:updated_at]).to be_a(String)
  end

  it 'Can get all merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_a(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:created_at)
      expect(merchant[:attributes][:created_at]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:updated_at)
      expect(merchant[:attributes][:updated_at]).to be_a(String)
    end
  end
  it 'Can create a merchant' do
    name = 'Dingle Hoppers'

    body = {
      name: name
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/merchants', headers: headers, params: JSON.generate(body)

    created_merchant = Merchant.last
    expect(response).to be_successful
    expect(created_merchant.name).to eq(body[:name])
  end
end
