# == Schema Information
# Schema version: 20130930182051
#
# Table name: repositories
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255)</tt>
# *user_id*::    <tt>integer, indexed</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#
# Indexes
#
#  index_repositories_on_user_id  (user_id)
#--
# == Schema Information End
#++

class Repository < ActiveRecord::Base
  #belongs_to :user
end
