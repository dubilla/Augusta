require "rails_helper"

RSpec.feature "League Profile", type: feature do
  let!(:league) { create :league, name: "First League" }
  let(:user) { create :user, first_name: "Sue", last_name: "Bird" }
  let!(:team) { create :team, user: user, league: league }
  let(:tournament) { create :tournament, name: "The Open" }
  let!(:league_tournament) { create :league_tournament, tournament: tournament, league: league }

  scenario "User sees league data" do
    given_i_visit_the_league_profile_page
    i_see_the_league_name
    i_see_the_team_members
    i_see_league_tournaments
  end

  def given_i_visit_the_league_profile_page
    visit league_path league
  end

  def i_see_the_league_name
    expect(page).to have_text "First League"
  end

  def i_see_the_team_members
    within "section", text: 'Teams' do
      expect(page).to have_text "Sue Bird"
    end
  end

  def i_see_league_tournaments
    within "section", text: "Tournaments" do
      expect(page).to have_text "The Open"
    end
  end
end
