class Product < ApplicationRecord
  include Uuidable
  include Localisable
  include Attachable

  belongs_to :account
  belongs_to :category, optional: true

  validates :name, presence: true

  monetize :price_cents

  delegate :uuid, to: :category, prefix: true
end
