require 'rails_helper'

describe 'Items API' do
  it 'Sends a list of items' do
    @merchant = create :merchant
    create_list(:item, 4, merchant: @merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(4)

    items[:data].each do |item|
      expect(item[:attributes]).to have_key(:id)
      expect(item[:attributes][:id]).to be_a(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)

      expect(item[:attributes]).to have_key(:created_at)
      expect(item[:attributes][:created_at]).to be_a(String)

      expect(item[:attributes]).to have_key(:updated_at)
      expect(item[:attributes][:updated_at]).to be_a(String)
    end
  end
  it 'Sends a single item' do
    @merchant = create :merchant
    item = create(:item, merchant: @merchant)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(4)

    expect(item[:data][:attributes]).to have_key(:id)
    expect(item[:data][:attributes][:id]).to be_a(Integer)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)

    expect(item[:data][:attributes]).to have_key(:created_at)
    expect(item[:data][:attributes][:created_at]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:updated_at)
    expect(item[:data][:attributes][:updated_at]).to be_a(String)
  end

  it 'Can Create an Item' do
    merchant = create :merchant
    name = 'Shiny Itemy Item'
    description = 'It does a lot of things real good'
    unit_price = 5011.96
    merchant_id = merchant.id

    item_params = { name: name,
                    description: description,
                    unit_price: unit_price,
                    merchant_id: merchant_id }

    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/items', headers: headers, params: JSON.generate(item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'Can delete and Item' do
    item = create :item

    expect(Item.all.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(Item.all.count).to eq(0)
  end

  it 'Can update an item' do
    item = create :item

    patch "/api/v1/items/#{item.id}?name=Testing"

    expect(Item.find(item.id).name).to eq('Testing')
  end
end
