require 'rails_helper'

describe 'Business intelligence endpoints' do
  before :each do
    @merchant1 = create(:merchant, name: 'merchant1')
    @merchant2 = create(:merchant, name: 'merchant2')
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant, name: 'merchant4')
    @merchant5 = create(:merchant, name: 'merchant5')
    @merchant6 = create(:merchant)
    @merchant7 = create(:merchant)
    @merchant8 = create(:merchant)
    @merchant9 = create(:merchant, name: 'merchant9')
    @merchant10 = create(:merchant)

    10.times do
      invoices = create_list(:invoice, 10, merchant: @merchant1)
      invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, quantity: 200, unit_price: 1000)
        create(:transaction, invoice: invoice)
      end
    end
    7.times do
      invoices = create_list(:invoice, 5, merchant: @merchant5)
      invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, quantity: 100, unit_price: 1000)
        create(:transaction, invoice: invoice)
      end
    end

    4.times do
      invoices = create_list(:invoice, 5, merchant: @merchant9)
      invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, quantity: 50, unit_price: 1000)
        create(:transaction, invoice: invoice)
      end
    end

    invoices = create_list(:invoice, 2, merchant: @merchant2)
    invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, quantity: 25, unit_price: 1000)
      create(:transaction, invoice: invoice)
    end

    invoices = create_list(:invoice, 2, merchant: @merchant4)
    invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, quantity: 5, unit_price: 1000)
      create(:transaction, invoice: invoice)
    end
  end

  it 'can get merchants with most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=5'
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json[:data].length).to eq(5)

    expect(json[:data][0][:attributes][:name]).to eq(@merchant1.name)
    expect(json[:data][0][:id]).to eq(@merchant1.id.to_s)

    expect(json[:data][1][:attributes][:name]).to eq(@merchant5.name)
    expect(json[:data][1][:id]).to eq(@merchant5.id.to_s)

    expect(json[:data][2][:attributes][:name]).to eq(@merchant9.name)
    expect(json[:data][2][:id]).to eq(@merchant9.id.to_s)
  end

  it 'can get merchants who have sold the most items' do
    get '/api/v1/merchants/most_items?quantity=3'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json[:data].length).to eq(3)

    expect(json[:data][0][:attributes][:name]).to eq(@merchant1.name)
    expect(json[:data][0][:id]).to eq(@merchant1.id.to_s)

    expect(json[:data][1][:attributes][:name]).to eq(@merchant5.name)
    expect(json[:data][1][:id]).to eq(@merchant5.id.to_s)

    expect(json[:data][2][:attributes][:name]).to eq(@merchant9.name)
    expect(json[:data][2][:id]).to eq(@merchant9.id.to_s)
  end

  it 'can get revenue between two dates' do
    get '/api/v1/revenue?start=2015-03-09&end=2017-03-24'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expected = Invoice.revenue('2015-03-09', '2017-03-24')[0].revenue

    expect(json[:data][:attributes][:revenue].to_f.round(2)).to eq(expected)
  end

  it 'can get revenue of a single merchant' do
    get "/api/v1/merchants/#{@merchant1.id}/revenue"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expected = @merchant1.revenue[0].revenue

    expect(json[:data][:id]).to be_nil
    expect(json[:data][:attributes][:revenue].to_f.round(2)).to eq(expected)
  end
end
