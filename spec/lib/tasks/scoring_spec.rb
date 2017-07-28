require "rails_helper"

describe "rake scoring:league_tournament_rosters", type: :task do
  let!(:league_tournament) { create :league_tournament }

  context "there are no ties" do
    let(:roster_winner) { create :roster, league_tournament: league_tournament }
    let!(:roster_winner_player1) { create :roster_player, final_score: -1, roster: roster_winner }
    let!(:roster_winner_player2) { create :roster_player, final_score: -3, roster: roster_winner }
    let(:roster_loser) { create :roster }
    let!(:roster_loser_player1) { create :roster_player, final_score: -1, roster: roster_loser }
    let!(:roster_loser_player2) { create :roster_player, final_score: -2, roster: roster_loser }

    it "marks the lowest score as the winner" do
      task.execute(lt_id: league_tournament.id)
      expect(roster_winner.reload.winner).to be_truthy
    end
  end
  context "there are ties" do
    let(:roster_winner1) { create :roster, league_tournament: league_tournament }
    let!(:roster_winner1_player1) { create :roster_player, final_score: -1, roster: roster_winner1 }
    let!(:roster_winner1_player2) { create :roster_player, final_score: -3, roster: roster_winner1 }
    let(:roster_winner2) { create :roster, league_tournament: league_tournament }
    let!(:roster_winner2_player1) { create :roster_player, final_score: -1, roster: roster_winner2 }
    let!(:roster_winner2_player2) { create :roster_player, final_score: -3, roster: roster_winner2 }

    it "marks both lowest scores as the winners" do
      task.execute(lt_id: league_tournament.id)
      expect(roster_winner1.reload.winner).to be_truthy
      expect(roster_winner2.reload.winner).to be_truthy
    end
  end
end
