require 'spec_helper'

describe ApplicationHelper do
  it 'builds trello API address with token and key' do

    expect(helper.trello_url('path', {key: 'key', token: 'token'})).to eq('https://api.trello.com/1/path?key=key&token=token')
  end
end
