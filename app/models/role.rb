class Role < ApplicationRecord
  ADMIN = "Admin".freeze
  HR_MANAGER = "HR Manager".freeze
  HR = "HR".freeze

  has_many :users
end
