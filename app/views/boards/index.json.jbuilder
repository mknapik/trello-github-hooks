json.array!(@boards) do |board|
  json.extract! board, :uid, :name, :repository_id
  json.url board_url(board, format: :json)
end
