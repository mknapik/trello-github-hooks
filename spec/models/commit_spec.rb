require 'spec_helper'

describe Commit do
  subject do
    commit = {
        'added' => [

        ],
        'author' => {
            'email' => 'lolwut@noway.biz',
            'name' => 'Garen Torikian',
            'username' => 'octokitty'
        },
        'committer' => {
            'email' => 'lolwut@noway.biz',
            'name' => 'Garen Torikian',
            'username' => 'octokitty'
        },
        'distinct' => true,
        'id' => 'c441029cf673f84c8b7db52d0a5944ee5c52ff89',
        'message' => 'Test',
        'modified' => [
            'README.md'
        ],
        'removed' => [

        ],
        'timestamp' => '2013-02-22T13:50:07-08:00',
        'url' => 'https://github.com/octokitty/testing/commit/c441029cf673f84c8b7db52d0a5944ee5c52ff89'
    }
    Commit.new(commit)
  end

  it 'should build Commit' do
    expect(subject.url).to eq 'https://github.com/octokitty/testing/commit/c441029cf673f84c8b7db52d0a5944ee5c52ff89'
    expect(subject.author).to eq 'octokitty'
    expect(subject.message).to eq 'Test'
  end

  it 'should have commit message with link to github' do
    expect(subject.comment).to eq 'octokitty: Test [c441029cf673f84c8b7db52d0a5944ee5c52ff89](https://github.com/octokitty/testing/commit/c441029cf673f84c8b7db52d0a5944ee5c52ff89)'
  end
end
