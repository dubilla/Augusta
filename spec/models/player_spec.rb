describe Player, type: :model do
  describe '#name' do
    let(:user) { build :user, first_name: 'Bobby', last_name: 'Bonilla' }
    it 'returns a concatenated name' do
      expect(user.name).to eq 'Bobby Bonilla'
    end
  end
end
