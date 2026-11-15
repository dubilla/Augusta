require "rails_helper"

RSpec.describe "Leaderboards", type: :request do
  let(:league) { create(:league) }
  let(:league_tournament) { create(:league_tournament, league: league, tournament: create(:tournament, completed: true)) }

  it "renders the leaderboard index" do
    get league_tournament_leaderboards_path(league, league_tournament)
    expect(response).to have_http_status(:ok)
  end

  it "has no leaderboard show route" do
    expect {
      get "#{league_tournament_leaderboards_path(league, league_tournament)}/1"
    }.to raise_error(ActionController::RoutingError)
  end
end
