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

  it 'touching in changes status to true' do
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end

  it 'touching in twice will raise an error' do
      subject.touch_in
      expect {subject.touch_in}.to raise_error "you have already touched in"
  end

  it 'touching out twice and also if it is not in use' do
      expect {subject.touch_out}.to raise_error "you have already touched out"
  end

  it 'when status is true, touch_out sets status to false' do
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end





  # it 'is currently in a journey' do
  #   expect(subject.in_journey?).to eq true
  # end
  #
  # it 'touching in sets the status to in use' do
  #   expect { subject.touch_in }.to change { subject.}.from('not in use').to('in use')
  # end




end
