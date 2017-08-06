require "rails_helper"

describe "rake finalizing:tournament", type: :task do
  let(:tournament) { create :tournament, external_id: 2700 }
  let(:league_tournament) { create :league_tournament, tournament: tournament }
  let(:roster) { create :roster, league_tournament: league_tournament }
  let(:rickie_fowler) { Player.find_by_external_id!(3702) }
  let(:adam_scott) { Player.find_by_external_id!(388) }
  let!(:roster_player1) { create :roster_player, roster: roster, player: rickie_fowler }
  let!(:roster_player2) { create :roster_player, roster: roster, player: adam_scott }

  it "copies scores to app" do
    VCR.use_cassette("finalizing_tournament") do
      task.execute(t_id: tournament.id)
      expect(roster.reload.roster_players.map(&:final_score)).to match_array [-1, -2]
    end
  end
end
