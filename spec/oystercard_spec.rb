require 'oystercard'
describe Oystercard do
  subject(:oystercard)  { described_class.new }
  it 'has a balance equal to 0 once created' do
    expect(oystercard.balance).to eq 0
  end

  it 'tops up the card' do
    subject.top_up(5.5)
    expect(oystercard.balance).to eq 5.5
  end

  error_message = "You cannot load more than £#{Oystercard::MAX_BALANCE}"

  it 'raises an error when top up limit reached with big single top up' do
    expect { oystercard.top_up(91) }.to raise_error error_message
  end

  it 'raises an erro when top up limit reached with a few top ups' do
    10.times { oystercard.top_up(8) }
    expect { subject.top_up(11) }.to raise_error error_message
  end
end
describe Oystercard do
  subject(:oystercard)  { described_class.new }
  # it 'deduct money from the card' do
  #   oystercard.top_up(10)
  #   expect(oystercard.deduct(5)).to eq 5.0
  # end
describe 'need to up before' do
  before do
  oystercard.top_up(5)
  end
  it 'is in journey once touch in' do
    oystercard.touch_in
    expect(oystercard.in_journey).to eq true
  end

  it 'is not in journey once touch out' do
    oystercard.touch_in
    oystercard.touch_out
    expect(subject.in_journey).to eq false
  end
  it 'charger minimum fare while touch out' do
    expect{ oystercard.touch_out }.to change{ oystercard.balance }.by -Oystercard::MINIMUM_FARE
  end
end

  it 'raise an error while there is no £ card while touch in' do
    error_message = "You are broken, not even a £#{Oystercard::MINIMUM_FARE} left"
    expect { oystercard.touch_in }.to raise_error error_message
  end

end
