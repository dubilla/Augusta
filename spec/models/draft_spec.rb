describe Draft, type: :model do
  let(:draft) { build :draft }
  describe '#open?' do
    subject do
      draft
    end
    describe "when the draft has not started yet" do
      before do
        draft.starts_at = 1.hour.from_now
      end
      it "is not open" do
        expect(subject.open?).to be false
      end
    end
    describe "when the draft has started and has not been completed" do
      before do
        draft.starts_at = 1.hour.ago
      end
      it "is open" do
        expect(subject.open?).to be true
      end
    end
    describe "when the draft has started and has been completed" do
      before do
        draft.starts_at = 1.hour.ago
        draft.completed_at = 30.minutes.ago
      end
      it "is not open" do
        expect(subject.open?).to be false
      end
    end
  end
end
