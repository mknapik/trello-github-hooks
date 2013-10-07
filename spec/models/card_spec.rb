require 'spec_helper'

describe Card do
  subject { Card.new({'id' => '1234567890', 'idShort' => '2'}) }

  it 'should build Card' do
    expect(subject.id).to eq '1234567890'
    expect(subject.short_id).to eq 2
  end

  it 'should check if is of short id' do
    expect(subject.has_short_id? 2).to be_true
    expect(subject.has_short_id? 3).to be_false
  end
end
