require "rails_helper"
RSpec.feature "Draft", type: feature do
  let(:league) { create :league }
  let(:tournament) { create :tournament }
  let(:league_tournament) { create :league_tournament, league: league, tournament: tournament }
  let!(:draft) { create :draft, league_tournament: league_tournament }

  context "as a user" do
    let!(:user) { create :user }
    let!(:team) { create :team, user: user, league: league }
    scenario "I can make a pick" do
      given_i_login user
      when_i_visit_the_draft_page
      i_can_see_my_league_is_drafting
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
  end
end
