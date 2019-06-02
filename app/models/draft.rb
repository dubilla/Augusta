class Draft < ApplicationRecord

  has_paper_trail

  belongs_to :league_tournament
  has_many :draft_slots

  delegate :league, to: :league_tournament

  def open?
    Time.current >= starts_at && completed_at.blank?
  end

end
