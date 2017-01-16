describe LeagueTournament, type: :model do
  describe 'associations' do
    it 'belongs to a league' do
      association = described_class.reflect_on_association(:league)
      expect(association.macro).to eq :belongs_to
    end
    it 'belongs to a tournament' do
      association = described_class.reflect_on_association(:tournament)
      expect(association.macro).to eq :belongs_to
    end
    it 'has many rosters' do
      association = described_class.reflect_on_association(:rosters)
      expect(association.macro).to eq :has_many
    end
  end
end
