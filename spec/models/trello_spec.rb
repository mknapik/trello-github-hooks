require 'spec_helper'

describe Trello do
  subject { Trello.new(':key', ':token') }

  it 'should build cards address' do
    result = subject.cards(':board_id')
    expect(result[:url]).to eq('https://api.trello.com/1/boards/:board_id/cards?key=:key&token=:token')
    expect(result[:body]).to eq({})
  end

  it 'should build comments address' do
    result = subject.comment(':card_id', ':comment')
    expect(result[:url]).to eq('https://api.trello.com/1/cards/:card_id/actions/comments?key=:key&token=:token')
    expect(result[:body]).to eq({:text => ':comment'})
  end
end
