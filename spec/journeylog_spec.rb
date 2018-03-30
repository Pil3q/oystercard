require 'journeylog'
describe JourneyLog do
  subject(:log) { described_class.new }

  let(:station) { double(:station, zone: 1) }
  let(:station2) { double(:station2, zone: 2)}

  it "saves completed journey" do
    log.start(station)
    log.end(station2)
    expect(log.log).to include({:start => station, :end => station2})
  end

  it 'saves incompleted journey (when touched in twice)' do
    log.start(station)
    log.start(station2)
    expect(log.log).to include({:start => station})
  end

  it 'saves incompleted journey (touch out but no touch in)' do
    log.end(station)
    expect(log.log).to include({:end => station})
  end
end
