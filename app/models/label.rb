class Label < ApplicationRecord
  has_many :marks, dependent: :destroy
  has_many :tasks, through: :marks 
end
