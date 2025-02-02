class Coupon < ApplicationRecord
  include NameSearchable
  include Paginatable
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :status, presence: true
  validates :discount_value, presence: true, numericality: { greater_than: 0 }
  validates :due_date, presence: true
  validates :due_date, presence: true, future_date: true # custom validator note.

  enum :status, { active: 1,  inactive: 2 }
end
