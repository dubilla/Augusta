require "rails_helper"
RSpec.feature "Draft", type: feature, js: true do
  let(:league) { create :league, name: "Up League" }
  let(:tournament) { create :tournament }
  let(:league_tournament) { create :league_tournament, league: league, tournament: tournament }
  let!(:draft) { create :draft, league_tournament: league_tournament }

  context "as a user" do
    let!(:user) { create :user }
    let!(:team) { create :team, user: user, league: league }
    let!(:jordan_spieth) { create :player, first_name: "Jordan", last_name: "Spieth" }
    let!(:tiger_woods) { create :player, first_name: "Tiger", last_name: "Woods" }
    let!(:draft_pick) { create :draft_pick, draft: draft, player: jordan_spieth }
    scenario "I can make a pick" do
      given_i_login user
      when_i_visit_the_draft_page
      i_can_see_my_league_is_drafting
      i_can_see_the_golfers_available
    end
  end

  def given_i_login user
    login_as user
  end

  def when_i_visit_the_draft_page
    visit league_league_tournament_path league, league_tournament
  end

  def i_can_see_my_league_is_drafting
    expect(page).to have_link "Enter Draft"
    click_link "Enter Draft"
    expect(page).to have_text "Up League Draft"
  end

  def i_can_see_the_golfers_available
    within "section", text: "Available Golfers" do
      expect(page).to have_text "Tiger Woods"
      expect(page).to have_no_text "Jordan Spieth"
    end
  end
end
