require 'spec_helper'

describe Board do
  subject { build(:board) }

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:repository) }
  it { should belong_to(:repository) }

  it 'should point to user key and token' do
    expect(subject.key).to eq(subject.user.trello_api_key)
    expect(subject.token).to eq(subject.user.trello_token)
  end

  it 'should build and return Trello object' do
    expect(subject.trello.key).to eq(subject.key)
    expect(subject.trello.token).to eq(subject.token)
  end
end
