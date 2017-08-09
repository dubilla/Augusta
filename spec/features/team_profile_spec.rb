require "rails_helper"

RSpec.feature "Team Profile", type: feature do
  let(:league) { create :league }
  let(:user) { create :user, first_name: "Steve", last_name: "Sax" }
  let(:team) { create :team, user: user, league: league }
  let!(:roster) { create :roster, team: team, winner: true }

  scenario "User sees team data" do
    given_i_visit_the_team_profile_page
    i_see_the_user_name
    i_see_the_team_wins
  end

  def given_i_visit_the_team_profile_page
    visit league_team_path league, team
  end

  def i_see_the_user_name
    expect(page).to have_text "Steve Sax"
  end

  def i_see_the_team_wins
    within "section", text: "Team Wins" do
      expect(page).to have_text "1"
    end
  end
end
