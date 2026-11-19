describe Roster, type: :model do
  describe '#score' do
    let(:roster) { create :roster }

    it 'is nil for a roster with no players' do
      expect(roster.score).to be_nil
    end

    it 'sums the roster players\' scores' do
      create :roster_player, roster: roster
      create :roster_player, roster: roster
      allow_any_instance_of(RosterPlayer).to receive(:score).and_return(-3)

      expect(roster.reload.score).to eq(-6)
    end
  end

  describe '#final_score' do
    let(:roster) { create :roster }
    let!(:roster_player_1) { create :roster_player, roster: roster, final_score: 6 }
    let!(:roster_player_2) { create :roster_player, roster: roster, final_score: 4 }

    it 'combines roster player scores' do
      expect(roster.final_score).to eq 10
    end
  end
end
