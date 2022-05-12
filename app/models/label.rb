class Label < ApplicationRecord
  has_many :marks, through: :marks, dependent: :destroy
end
