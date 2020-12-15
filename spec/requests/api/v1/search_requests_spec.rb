require 'rails_helper'

describe 'Search API endpoints' do
  it "can find a list of merchants that contain a fragment, case insensitive" do
    merchant1 = create(:merchant, name: "Schiller, Barrows and Parker")
    merchant2 = create(:merchant, name: "Tillman Group")
    merchant3 = create(:merchant, name: "Williamson Group")
    merchant4 = create(:merchant, name: "Willms and Sons")
    merchants_names = [merchant1.name, merchant2.name, merchant3.name, merchant4.name]  
  
    get '/api/v1/merchants/find_all?name=ILL'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    names = json[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(names.sort).to eq(merchants_names)
  end

  it "can find a merchant that contain a fragment, case insensitive" do
    merchant1 = create(:merchant, name: "Schiller, Barrows and Parker")
    merchant2 = create(:merchant, name: "Tillman Group")
    merchant3 = create(:merchant, name: "Williamson Group")
    merchant4 = create(:merchant, name: "Willms and Sons")

    get '/api/v1/merchants/find?name=ILL'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    name = json[:data][:attributes][:name].downcase

    expect(json[:data]).to be_a(Hash)
    expect(name).to include('ill')
  end
end
