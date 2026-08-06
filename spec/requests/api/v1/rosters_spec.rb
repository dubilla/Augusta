require "rails_helper"

# Smoke coverage for the JSON:API endpoint + jsonapi-rails serializers, which
# have zero coverage despite crossing major Rails/gem versions in this upgrade.
# One case proves the empty-collection plumbing (route -> controller ->
# jsonapi rendering); one proves an actual roster serializes through
# SerializableRoster. Roster#score reaches an external score parser over the
# network, so it is stubbed here to keep the smoke test hermetic.
RSpec.describe "Api::V1::Rosters", type: :request do
  it "returns an empty JSON:API collection when a tournament has no rosters" do
    league_tournament = create(:league_tournament)

    get "/api/v1/rosters", params: { league_tournament_id: league_tournament.id }

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to match(%r{application/vnd\.api\+json})
    expect(JSON.parse(response.body)["data"]).to eq([])
  end

  it "serializes a roster's score and team name for the tournament" do
    league_tournament = create(:league_tournament)
    user = create(:user)
    team = create(:team, user: user)
    create(:roster, team: team, league_tournament: league_tournament)
    # Roster#score hits an external score parser; stub it for a hermetic smoke.
    allow_any_instance_of(Roster).to receive(:score).and_return(42)

    get "/api/v1/rosters", params: { league_tournament_id: league_tournament.id }

    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body["data"].size).to eq(1)
    expect(body["data"].first["type"]).to eq("roster")
    attributes = body["data"].first["attributes"]
    expect(attributes["score"]).to eq(42)
    expect(attributes["name"]).to eq(user.name)
  end
end
