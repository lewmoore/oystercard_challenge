require 'station'

describe Station do
  subject(:station) { described_class.new('Barking', 4) }
  it 'expects the station to have a zone' do
    is_expected.to respond_to :zone
  end

  it 'expects station to have a name' do
    is_expected.to respond_to :name
  end
end
