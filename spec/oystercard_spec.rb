require 'oystercard'
describe Oystercard do
  it 'has a balance equal to 0 once created' do
    expect(subject.balance).to eq 0
  end
end
