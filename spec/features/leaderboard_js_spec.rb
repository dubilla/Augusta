require "rails_helper"

RSpec.feature "Leaderboard JavaScript", type: :feature, js: true do
  let(:league) { create :league }
  let(:league_tournament) { create :league_tournament, league: league, tournament: create(:tournament, completed: true) }

  scenario "pages without a leaderboard load without JavaScript errors" do
    visit root_path
    expect(page).to have_css("body")
  end

  scenario "the leaderboard renders team and player leaders" do
    brad = create :user, first_name: "Brad", last_name: "Friedel"
    cristian = create :user, first_name: "Cristian", last_name: "Penilla"
    brad_roster = create :roster, team: create(:team, user: brad), league_tournament: league_tournament
    cristian_roster = create :roster, team: create(:team, user: cristian), league_tournament: league_tournament
    create :roster_player, roster: brad_roster, player: create(:player, first_name: "Greg", last_name: "Norman")
    create :roster_player, roster: cristian_roster, player: create(:player, first_name: "Nick", last_name: "Faldo")
    allow_any_instance_of(Roster).to receive(:score).and_return(-7)
    allow_any_instance_of(RosterPlayer).to receive(:score).and_return(-4)
    allow_any_instance_of(RosterPlayer).to receive(:status).and_return("F")

    visit league_tournament_leaderboards_path(league, league_tournament)

    within("#team-leaders") do
      expect(page).to have_css("tr", count: 2)
      expect(page).to have_text("Brad Friedel")
      expect(page).to have_text("Cristian Penilla")
    end
    within("#player-leaders tbody") do
      expect(page).to have_css("tr", count: 2)
      expect(page).to have_text("Greg Norman")
      expect(page).to have_text("Nick Faldo")
    end
  end
end
