require 'journey'
describe Journey do
subject(:journey)  { described_class.new }
  it 'keeps an entry station' do
    station = double(:station)
    journey.start(station)
    expect(journey.entry_station).to eq station
  end
  it 'has incompleted journey as a default' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end
  it 'in and out makes the complete journey' do
    station = double(:station)
    journey.start(station)
    journey.end(station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end
  it 'charges penalty if no touch_in' do
    station = double(:station)
    journey.end(station)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end
end
