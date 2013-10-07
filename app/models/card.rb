class Card
  include ActiveAttr::Attributes

  def initialize(card)
    self.id = card['id']
    self.short_id = card['idShort'].to_i
  end

  def has_short_id?(short_id)
    self.short_id == short_id
  end

  attribute :id
  attribute :short_id
end