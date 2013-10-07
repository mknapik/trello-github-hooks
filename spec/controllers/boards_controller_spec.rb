require 'spec_helper'

describe BoardsController do

  # This should return the minimal set of attributes required to create a valid
  # Board. As you add validations to Board, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    attributes_for(:board)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Boards Controller.Be sure to keep this updated too.
  def valid_session
    {}
  end

  before do
    sign_in build(:user)
  end

  describe '#push' do
    payload = "{    \"after\":\"1481a2de7b2a7d02428ad93446ab166be7793fbb\",    \"before\":\"17c497ccc7cca9c2f735aa07e9e3813060ce9a6a\",    \"commits\":[       {          \"added\":[            ],          \"author\":{             \"email\":\"lolwut@noway.biz\",             \"name\":\"Garen Torikian\",             \"username\":\"octokitty\"          },          \"committer\":{             \"email\":\"lolwut@noway.biz\",             \"name\":\"Garen Torikian\",             \"username\":\"octokitty\"          },          \"distinct\":true,          \"id\":\"c441029cf673f84c8b7db52d0a5944ee5c52ff89\",          \"message\":\"Test\",          \"modified\":[             \"README.md\"          ],          \"removed\":[            ],          \"timestamp\":\"2013-02-22T13:50:07-08:00\",          \"url\":\"https://github.com/octokitty/testing/commit/c441029cf673f84c8b7db52d0a5944ee5c52ff89\"       },       {          \"added\":[            ],          \"author\":{             \"email\":\"lolwut@noway.biz\",             \"name\":\"Garen Torikian\",             \"username\":\"octokitty\"          },          \"committer\":{             \"email\":\"lolwut@noway.biz\",             \"name\":\"Garen Torikian\",             \"username\":\"octokitty\"          },          \"distinct\":true,          \"id\":\"36c5f2243ed24de58284a96f2a643bed8c028658\",          \"message\":\"This is me testing the windows client.\",          \"modified\":[             \"README.md\"          ],          \"removed\":[            ],          \"timestamp\":\"2013-02-22T14:07:13-08:00\",          \"url\":\"https://github.com/octokitty/testing/commit/36c5f2243ed24de58284a96f2a643bed8c028658\"       },       {          \"added\":[             \"words/madame-bovary.txt\"          ],          \"author\":{             \"email\":\"lolwut@noway.biz\",             \"name\":\"Garen Torikian\",             \"username\":\"octokitty\"          },          \"committer\":{             \"email\":\"lolwut@noway.biz\",             \"name\":\"Garen Torikian\",             \"username\":\"octokitty\"          },          \"distinct\":true,          \"id\":\"1481a2de7b2a7d02428ad93446ab166be7793fbb\",          \"message\":\"Rename madame-bovary.txt to words/madame-bovary.txt\",          \"modified\":[            ],          \"removed\":[             \"madame-bovary.txt\"          ],          \"timestamp\":\"2013-03-12T08:14:29-07:00\",          \"url\":\"https://github.com/octokitty/testing/commit/1481a2de7b2a7d02428ad93446ab166be7793fbb\"       }    ],    \"compare\":\"https://github.com/octokitty/testing/compare/17c497ccc7cc...1481a2de7b2a\",    \"created\":false,    \"deleted\":false,    \"forced\":false,    \"head_commit\":{       \"added\":[          \"words/madame-bovary.txt\"       ],       \"author\":{          \"email\":\"lolwut@noway.biz\",          \"name\":\"Garen Torikian\",          \"username\":\"octokitty\"       },       \"committer\":{          \"email\":\"lolwut@noway.biz\",          \"name\":\"Garen Torikian\",          \"username\":\"octokitty\"       },       \"distinct\":true,       \"id\":\"1481a2de7b2a7d02428ad93446ab166be7793fbb\",       \"message\":\"Rename madame-bovary.txt to words/madame-bovary.txt\",       \"modified\":[         ],       \"removed\":[          \"madame-bovary.txt\"       ],       \"timestamp\":\"2013-03-12T08:14:29-07:00\",       \"url\":\"https://github.com/octokitty/testing/commit/1481a2de7b2a7d02428ad93446ab166be7793fbb\"    },    \"pusher\":{       \"email\":\"lolwut@noway.biz\",       \"name\":\"Garen Torikian\"    },    \"ref\":\"refs/heads/master\",    \"repository\":{       \"created_at\":1332977768,       \"description\":\"\",       \"fork\":false,       \"forks\":0,       \"has_downloads\":true,       \"has_issues\":true,       \"has_wiki\":true,       \"homepage\":\"\",       \"id\":3860742,       \"language\":\"Ruby\",       \"master_branch\":\"master\",       \"name\":\"testing\",       \"open_issues\":2,       \"owner\":{          \"email\":\"lolwut@noway.biz\",          \"name\":\"octokitty\"       },       \"private\":false,       \"pushed_at\":1363295520,       \"size\":2156,       \"stargazers\":1,       \"url\":\"https://github.com/octokitty/testing\",       \"watchers\":1    } }"

    it 'returns error on empty params' do
      expect {
        post :push, {}
      }.to raise_error
    end

    it 'returns error on empty payload' do
      expect {
        post :push, {'payload' => '{}'}
      }.to raise_error
    end

    context 'repository exists' do
      before do
        octokitty = User.create!(email: 'octokitty@github.com', password: 'password')
        repository = Repository.create!(name: 'octokitty/testing', user: octokitty)
        board = Board.create!(uid: 'uid', name: 'name', repository: repository)
      end

      it 'sends no comment' do
        request.accept = 'application/json'
        post :push, {'payload' => payload}
        expect(response).to be_success
        expect(JSON.parse(response.body)['success']).to be_true
        expect(JSON.parse(response.body)['comments']).to be_empty
        expect(JSON.parse(response.body)['errors']).to be_empty
      end
    end

    context 'repository does not exist' do

      it 'sends no comment' do
        request.accept = 'application/json'
        post :push, {'payload' => payload}
        expect(response).to be_success
        expect(JSON.parse(response.body)['success']).to be_false
        expect(JSON.parse(response.body)['comments']).to be_empty
        expect(JSON.parse(response.body)['errors']).to_not be_empty
      end
    end
  end
end
