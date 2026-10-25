class SalaryRecord < ApplicationRecord
  belongs_to :user
  belongs_to :role
  validates :compensation,
            presence: true,
            numericality: { greater_than: 0 }
end
