describe Roster, type: :model do
  describe '#final_score' do
    let(:roster) { create :roster }
    let!(:roster_player_1) { create :roster_player, roster: roster, final_score: 6 }
    let!(:roster_player_2) { create :roster_player, roster: roster, final_score: 4 }

    it 'combines roster player scores' do
      expect(roster.final_score).to eq 10
    end
  end
end
