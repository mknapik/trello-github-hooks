class AddTokensToUser < ActiveRecord::Migration
  def change
    add_column :users, :trello_api_key, :string
    add_column :users, :trello_token, :string
  end
end
