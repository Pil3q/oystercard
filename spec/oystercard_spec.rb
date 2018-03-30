require 'oystercard'
require 'journey'
require 'journeylog'
describe Oystercard do
  subject(:oystercard)  { described_class.new }
  it 'has a balance equal to 0 once created' do
    expect(oystercard.balance).to eq 0
  end

  it 'has an empty journey history on creation' do
    expect(oystercard.journeylog.log).to eq []
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

describe 'need to top up before' do
  before do
  oystercard.top_up(5)
  end
  it 'check is the journey record after in and out' do
    entry_station = double(:entry_station, zone: 1)
    exit_station = double(:exit_station, zone: 1)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journeylog.log).to include({:start => entry_station, :end => exit_station})
  end
  it 'is in journey once touch in' do
    station = double(:station)
    oystercard.touch_in(station)
    expect(oystercard.journeylog.current_journey).to include({:start => station})
  end

  it 'is not in journey once touch out' do
    station = double(:station, zone: 1)
    oystercard.touch_in(station)
    oystercard.touch_out(station)
    empty = {}
    expect(subject.journeylog.current_journey).to eq empty
  end
  it 'charge minimum fare while touch out' do
    station = double(:station, zone: 1)
    oystercard.touch_in(station)
    expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by -Oystercard::MINIMUM_FARE
  end
  it "should remember touch in station" do
    station = double(:station, zone: 1)
    oystercard.touch_in(station)
    expect(oystercard.journeylog.journey.entry_station).to eq station
  end
end

  it 'raise an error while there is no £ card while touch in' do
    station = double(:station)
    error_message = "You are broken, not even a £#{Oystercard::MINIMUM_FARE} left"
    expect { oystercard.touch_in(station) }.to raise_error error_message
  end
end
