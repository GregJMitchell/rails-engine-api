require 'rails_helper'

describe 'Items API' do
  it 'Sends a list of items' do
    @merchant = create :merchant
    create_list(:item, 4, merchant: @merchant)

    get '/api/v1/items'

    expect(response).to be_successful
  end
end
