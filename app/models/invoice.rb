class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  def self.revenue(start_date, end_date)
    end_date += 'T23:59:59'
    Invoice.joins(:transactions, :invoice_items)
           .select('SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
           .where(transactions: { result: 'success' })
           .where(invoices: { status: 'shipped' })
           .where('invoices.created_at >= ?', start_date.to_s)
           .where('invoices.created_at <= ?', end_date.to_s)
  end
end
