require 'oystercard'
require 'journeylog'
describe Oystercard do
  subject(:oystercard)  { described_class.new }

  describe 'basic tests' do

    it 'has a balance equal to 0 once created' do
      expect(oystercard.balance).to eq 0
    end

    it 'has an empty journey history as default' do
      expect(oystercard.journeys).to eq []
    end

    it 'tops up the card' do
      subject.top_up(5.5)
      expect(oystercard.balance).to eq 5.5
    end
  end

  describe 'error tests' do

    error_message = "You cannot load more than £#{Oystercard::MAX_BALANCE}"
    error_message2 = "You are broken, not even a £#{Oystercard::MINIMUM_FARE} left"

    it 'raises an error when top up limit reached with a single top up' do
      expect { oystercard.top_up(91) }.to raise_error error_message
    end

    it 'raises an erro when top up limit reached with a few top ups' do
      10.times { oystercard.top_up(8) }
      expect { subject.top_up(11) }.to raise_error error_message
    end

    it 'raise an error while there is no £ card while touch in' do
      station = double(:station)
      expect { oystercard.touch_in(station) }.to raise_error error_message2
    end
  end

  describe 'tests with top up and touch_in as a start' do

    before do
    oystercard.top_up(5)
    oystercard.touch_in(station)
    end

    let(:station) { double(:station, zone: 1) }
    let(:station2) { double(:station2, zone: 4) }

    it 'check is the journey record after in and out' do
      oystercard.touch_out(station2)
      expect(oystercard.journeylog.log).to include({:start => station, :end => station2})
    end

    it 'is in journey once touch in' do
      expect(oystercard.journeylog.current_journey).to include({:start => station})
    end

    it 'is not in journey once touch out' do
      oystercard.touch_out(station2)
      empty = {}
      expect(subject.journeylog.current_journey).to eq empty
    end

    it 'charge minimum fare while touch out' do
      expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by -Oystercard::MINIMUM_FARE
    end

    it "should remember touch in station" do
      expect(oystercard.journeylog.journey.entry_station).to eq station
    end

    it 'charges zone fare' do
      zone_fare = (station.zone - station2.zone).abs
      oystercard.touch_out(station2)
      expect(oystercard.balance).to eq (5 - Oystercard::MINIMUM_FARE - zone_fare)
    end
  end
end
