class Trello
  include ActiveAttr::Attributes
  include ApplicationHelper

  def initialize(key, token)
    self.key = key
    self.token = token
  end

  def cards(board_uid)
    {:url => trello_url("boards/#{board_uid}/cards", key: self.key, token: self.token),
     :body => {}}
  end

  def comment(card_id, message)
    {:url => trello_url("cards/#{card_id}/actions/comments", key: self.key, token: self.token),
     :body => {:text => message}}
  end

  attribute :key
  attribute :token
end