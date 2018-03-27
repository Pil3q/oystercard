require 'oystercard'
describe Oystercard do
  it 'has a balance equal to 0 once created' do
    expect(subject.balance).to eq 0
  end

  it 'tops up the card' do
    subject.top_up(5.5)
    expect(subject.balance).to eq 5.5
  end

  error_message = "You cannot load more than £#{Oystercard::MAX_BALANCE}"

  it 'raises an error when top up limit reached with big single top up' do
    expect { subject.top_up(91) }.to raise_error error_message
  end

  it 'raises an erro when top up limit reached with a few top ups' do
    10.times { subject.top_up(8) }
    expect { subject.top_up(11) }.to raise_error error_message
  end
end
describe Oystercard do
  it 'deduct money from the card' do
    subject.top_up(10)
    expect(subject.deduct(5)).to eq 5.0
  end

  it 'is in journey once touch in' do
    subject.top_up(10)
    subject.touch_in
    expect(subject.in_journey).to eq true
  end

  it 'is not in journey once touch out' do
    subject.top_up(10)
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey).to eq false
  end

  it 'raise an error while there is no £ card while touch in' do
    error_message = "You are broken, not even a £#{Oystercard::MINIMUM_FARE} left"
    expect { subject.touch_in }.to raise_error error_message
  end
end
