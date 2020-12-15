class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items

  scope :search_all, ->(search) { where('name ILIKE :search', search: "%#{search.downcase}%") }
  scope :search_one, ->(search) { find_by('name ILIKE :search', search: "%#{search.downcase}%") }
end
