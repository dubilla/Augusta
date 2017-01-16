describe League, type: :model do
  describe 'associations' do
    it 'has many league tournaments' do
      association = described_class.reflect_on_association(:league_tournaments)
      expect(association.macro).to eq :has_many
    end
    it 'has many tournaments through league tournaments' do
      association = described_class.reflect_on_association(:tournaments)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :league_tournaments
    end
    it 'shas many teams' do
      association = described_class.reflect_on_association(:teams)
      expect(association.macro).to eq :has_many
    end
  end
end
