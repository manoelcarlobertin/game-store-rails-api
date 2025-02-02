class Game < ApplicationRecord
  scope :like, ->(field, value) {
    where("#{field} ILIKE ?", "%#{value}%") # Para PostgreSQL
  }
  # include LikeSearchable
  enum :mode, { pvp: 1, pve: 2, both: 3 } # alterei aqui
  belongs_to :system_requirement
  has_one :product, as: :productable

  validates :mode, presence: true # integer values
  validates :release_date, presence: true
  validates :developer, presence: true
end
