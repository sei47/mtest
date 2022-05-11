class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name, presence: true
  validates :email, presence: true

  before_update :block_admin_absence
  has_secure_password
  has_many :tasks, dependent: :destroy

  private

  def block_admin_absence
    unless self.admin_flag
      throw(:abort) unless User.where(admin_flag: true).where.not(id: self.id).present?
    end
  end
end
