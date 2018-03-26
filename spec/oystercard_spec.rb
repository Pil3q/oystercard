require 'oystercard'
describe Oystercard do
  it 'has a balance equal to 0 once created' do
    expect(subject.balance).to eq 0
  end
  it 'tops up the card' do
    subject.top_up(5.5)
    expect(subject.balance).to eq 5.5
  end
  error_message = "You cannot load more than #{Oystercard::MAX_BALANCE}"
  it 'raises an error when top up limit reached with big single top up' do
    expect { subject.top_up(91) }.to raise_error error_message
  end
  it 'raises an erro when top up limit reached with a few top ups' do
  10.times { subject.top_up(8) }
  expect { subject.top_up(11) }.to raise_error error_message
  end
end
