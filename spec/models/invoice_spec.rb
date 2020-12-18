require 'rails_helper'

describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'Model methods' do
    before :each do
      invoices = create_list(:invoice, 10)
      invoices.each do |invoice|
        create(:invoice_item, invoice: invoice, quantity: 200, unit_price: 1000)
        create(:transaction, invoice: invoice)
      end
    end

    it '#revenue' do
      revenue = Invoice.revenue('2014-09-23', '2020-09-25')

      expect(revenue[0].revenue).to eq(2_000_000.0)
    end
  end
end
