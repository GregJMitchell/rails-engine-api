class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  scope :search_all, ->(search) { where('name ILIKE :search', search: "%#{search.downcase}%") }
  scope :search_one, ->(search) { find_by('name ILIKE :search', search: "%#{search.downcase}%") }
end
