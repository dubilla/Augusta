describe League, type: :model do
  describe 'associations' do
    it 'has many league tournaments' do
      association = described_class.reflect_on_association(:league_tournaments)
      expect(association.macro).to eq :has_many
    end
  end
end
