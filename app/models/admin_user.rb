class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  # Deliberately excludes Devise secrets (encrypted_password, reset_password_token).
  def self.ransackable_attributes(_auth_object = nil)
    %w[id email created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
