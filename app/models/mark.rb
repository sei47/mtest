class Mark < ApplicationRecord
  belongs_to :label
  belongs_to :task
end
