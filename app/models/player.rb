class Player < ApplicationRecord

  has_paper_trail

  belongs_to :team, inverse_of: :players

  validates :external_id, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id first_name last_name external_id team_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[team]
  end

end
