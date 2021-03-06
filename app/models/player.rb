class Player < ApplicationRecord

  has_paper_trail

  belongs_to :team, inverse_of: :players

  validates :external_id, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end

end
