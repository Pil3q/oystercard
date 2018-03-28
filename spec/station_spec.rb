require 'station'
describe Station do
  # subject(:station) { described_class.new}
  station = Station.new(3, :bank)
  it 'comes with the zone' do
    expect(station.zone).to eq 3
  end
  it 'comes with the name' do
    expect(station.name).to eq :bank
  end
end
