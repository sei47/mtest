class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name, presence: true
  validates :email, presence: true

  after_update :block_admin_absence if User.find_by(admin_flag: "true") == nil
  after_destroy :block_admin_absence if User.find_by(admin_flag: "true") == nil

  has_secure_password
  has_many :tasks, dependent: :destroy

  private

  def block_admin_absence
    flash.now[:danger] = '管理者が他にいません'
  end
end
