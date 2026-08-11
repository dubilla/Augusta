class User < ApplicationRecord

  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :team, inverse_of: :user

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  # Deliberately excludes Devise secrets and sign-in tracking/IP columns.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id email first_name last_name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[team]
  end

  def name
    [first_name, last_name].join(" ")
  end

end
