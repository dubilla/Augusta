require "rails_helper"

RSpec.feature "League Tournament Profile", type: feature do
  let(:league) { create :league }
  let(:tournament) { create :tournament }
  let(:league_tournament) { create :league_tournament, tournament: tournament, league: league }
  let(:brad_friedel) { create :user, first_name: "Brad", last_name: "Friedel" }
  let(:cristian_penilla) { create :user, first_name: "Cristian", last_name: "Penilla" }
  let(:brad_friedel_team) { create :team, user: brad_friedel }
  let(:cristian_penilla_team) { create :team, user: cristian_penilla }
  let!(:roster_loser) { create :roster, winner: false, team: brad_friedel_team, league_tournament: league_tournament }
  let!(:roster_winner) { create :roster, winner: true, team: cristian_penilla_team, league_tournament: league_tournament }

  scenario "User sees league tournament winner" do
    given_i_visit_the_league_tournament_profile_page
    i_see_the_league_tournament_roster_winner
  end

  def given_i_visit_the_league_tournament_profile_page
    visit league_league_tournament_path league, league_tournament
  end

  def i_see_the_league_tournament_roster_winner
    within "section", text: "Winners" do
      within "tr", text: "Roster Winner"  do
        expect(page).to have_text "Cristian Penilla"
      end
    end
  end
end
