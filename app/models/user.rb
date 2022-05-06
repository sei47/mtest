class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name, presence: true
  validates :email, presence: true

  has_secure_password
  has_many :tasks
end
