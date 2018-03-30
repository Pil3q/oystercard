require 'journey'
describe Journey do
subject(:journey)  { described_class.new }
  let(:station) { double(:station, zone: 1)}
  it 'keeps an entry station' do
    journey.start(station)
    expect(journey.entry_station).to eq station
  end
  it 'has incompleted journey fare as a default' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end
  it 'in and out makes the complete journey' do
    journey.start(station)
    journey.end(station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end
  it 'charges penalty if no touch_in' do
    journey.end(station)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end
  it 'charge fare for crossing zones' do
    station2 = double(:station2, zone: 4)
    zone_fare = (station.zone - station2.zone).abs
    journey.start(station)
    journey.end(station2)
    expect(journey.fare).to eq (Journey::MINIMUM_FARE + zone_fare)
  end
end
