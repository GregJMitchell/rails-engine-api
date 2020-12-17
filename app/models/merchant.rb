class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items

  has_many :invoices

  has_many :invoice_items, through: :invoices

  scope :search_all, ->(search) { where('name ILIKE :search', search: "%#{search.downcase}%") }
  scope :search_one, ->(search) { find_by('name ILIKE :search', search: "%#{search.downcase}%") }

  def self.most_revenue(quantity)
    Merchant.joins(invoices: %i[transactions invoice_items])
            .where(transactions: { result: 'success' })
            .where(invoices: { status: 'shipped' })
            .select('merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue')
            .group('merchants.id')
            .order('revenue desc')
            .limit(quantity.to_i)
  end

  def self.most_items(quantity)
    Merchant.joins(invoices: %i[transactions invoice_items])
            .where(transactions: { result: 'success' })
            .select('merchants.*, sum(invoice_items.quantity) as total_sold')
            .group('merchants.id')
            .order('total_sold desc')
            .limit(quantity.to_i)
  end
end
