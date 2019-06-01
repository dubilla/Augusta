require "rails_helper"

RSpec.feature "League Tournament Profile", type: feature do
  let(:league) { create :league, name: "Fore" }
  let(:tournament) { create :tournament, name: "U.S. Open" }
  let(:league_tournament) { create :league_tournament, tournament: tournament, league: league }
  let!(:open_draft) { create :draft, league_tournament: league_tournament, starts_at: 1.hour.ago }
  let(:brad_friedel) { create :user, first_name: "Brad", last_name: "Friedel" }
  let(:cristian_penilla) { create :user, first_name: "Cristian", last_name: "Penilla" }
  let(:brad_friedel_team) { create :team, user: brad_friedel }
  let(:cristian_penilla_team) { create :team, user: cristian_penilla }
  let!(:roster_loser) { create :roster, winner: false, team: brad_friedel_team, league_tournament: league_tournament }
  let!(:roster_winner) { create :roster, winner: true, team: cristian_penilla_team, league_tournament: league_tournament }
  let(:greg_norman) { create :player, first_name: "Greg", last_name: "Norman" }
  let!(:roster_player_winner) { create :roster_player, winner: true, roster: roster_loser, player: greg_norman }

  before do
    given_i_visit_the_league_tournament_profile_page
  end

  scenario "User sees league tournament winner" do
    i_see_the_league_tournament_roster_winner
    and_the_league_tournament_roster_player_winner_with_user
  end

  scenario "User sees draft in progress" do
    i_see_the_draft_link
    and_i_can_access_the_draft
  end

  def given_i_visit_the_league_tournament_profile_page
    visit league_tournament_path league, league_tournament
  end

  def i_see_the_league_tournament_roster_winner
    within "section", text: "Roster Winner" do
      expect(page).to have_text "Cristian Penilla"
    end
  end

  def and_the_league_tournament_roster_player_winner_with_user
    within "section", text: "Individual Winner" do
      expect(page).to have_text "Brad Friedel"
      expect(page).to have_text "Greg Norman"
    end
  end

  def i_see_the_draft_link
    expect(page).to have_text "Join the Draft"
  end

  def and_i_can_access_the_draft
    click_link "Join the Draft"
    expect(page).to have_text "Fore U.S. Open Draft"
  end
end
