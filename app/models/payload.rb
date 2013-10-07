class Payload
  include ActiveAttr::Attributes

  def initialize(payload_data)
    payload = if payload_data.is_a? String
                JSON.parse(payload_data)
              else
                payload_data
              end

    raise ArgumentError, 'No payload' if payload.nil?
    raise ArgumentError, 'Payload is not of a valid format' if
        payload['repository'].nil? or
        payload['repository']['owner'].nil? or
        payload['repository']['owner']['name'].nil?

    self.repository_owner = payload['repository']['owner']['name']
    self.repository_name = "#{payload['repository']['owner']['name']}/#{payload['repository']['name']}"

    self.commits = payload['commits'].map do |commit_data|
      Commit.new(commit_data)
    end
  end

  attribute :repository_owner
  attribute :repository_name
  attribute :commits
end
