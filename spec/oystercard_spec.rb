require 'oystercard'

MAX_AMOUNT = 90

describe Oystercard do
  it { is_expected.to respond_to :balance }

  it "has a balance of 0" do
    expect(subject.balance).to eq 0
  end

  it "tops up the oystercard" do
    expect(subject.top_up(10)).to eq 10
  end

  it "to raise an error if top up amount is greater than 90" do
    expect {subject.top_up(100)}.to raise_error "the oystercard cannot store above #{MAX_AMOUNT}"
  end

  it "to deduct money from oystercard" do
    subject.top_up(30)
    expect(subject.deduct(10)).to eq 20
  end

  it 'is currently in a journey' do
    expect(subject.in_journey?).to eq true
  end




end
