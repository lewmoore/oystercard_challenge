require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to :balance }

  it "has a balance of 0" do
    expect(subject.balance).to eq 0
  end

  it "tops up the oystercard" do
    expect(subject.top_up(10)).to eq 10
  end

end
