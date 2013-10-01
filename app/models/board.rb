# == Schema Information
# Schema version: 20131001071632
#
# Table name: boards
#
# *id*::            <tt>integer, not null, primary key</tt>
# *uid*::           <tt>string(255)</tt>
# *name*::          <tt>string(255)</tt>
# *repository_id*:: <tt>integer, indexed</tt>
# *created_at*::    <tt>datetime</tt>
# *updated_at*::    <tt>datetime</tt>
#
# Indexes
#
#  index_boards_on_repository_id  (repository_id)
#--
# == Schema Information End
#++

class Board < ActiveRecord::Base
  belongs_to :repository

  validates :uid,
            presence: true
  validates :name,
            presence: true
  validates :repository,
            presence: true

  def key
    self.repository.try(:user).try(:trello_api_key)
  end

  def token
    self.repository.try(:user).try(:trello_token)
  end

  def user
    self.repository.try(:user)
  end
end
