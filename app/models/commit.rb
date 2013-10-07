class Commit
  include ActiveAttr::Attributes

  def initialize(commit)
    self.id = commit['id']
    self.url = commit['url']
    self.author = commit['author']['username']
    self.message = commit['message']
    self.comment = "#{self.author}: #{self.message} [#{self.id}](#{self.url})"
  end

  #check if contains task marker '#number'
  def has_refs?
    set_match
    not @match.nil?
  end

  def short_id
    set_match
    (@match.nil? and -1) or @match[:idShort].to_i
  end

  attribute :id
  attribute :url
  attribute :author
  attribute :message
  attribute :comment

  private

  def set_match
    @match ||= self.comment.match(/\#(?<idShort>\d+)/)
  end
end