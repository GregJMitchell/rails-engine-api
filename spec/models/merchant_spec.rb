require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'model methods' do
    before :each do
      @merchant1 = create(:merchant, name: 'merchant1')
      @merchant2 = create(:merchant, name: 'merchant2')

      5.times do
        invoices = create_list(:invoice, 10, merchant: @merchant1)
        invoices.each do |invoice|
          create(:invoice_item, invoice: invoice, quantity: 200, unit_price: 1000)
          create(:transaction, invoice: invoice)
        end
      end

      invoices = create_list(:invoice, 2, merchant: @merchant2)
      invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, quantity: 25, unit_price: 1000)
        create(:transaction, invoice: invoice)
      end
    end

    it '#most_revenue' do
      merchants = Merchant.most_revenue(2.to_s)

      expect(merchants[0].name).to eq(@merchant1.name)
    end

    it '#most_items' do
      merchants = Merchant.most_items(2.to_s)

      expect(merchants[0].name).to eq(@merchant1.name)
    end

    it '#revenue' do
      revenue = @merchant1.revenue

      expect(revenue[0].revenue).to eq(10_000_000.0)
    end
  end
end
