json.array!(@repositories) do |repository|
  json.extract! repository, :name, :user_id
  json.url repository_url(repository, format: :json)
end
