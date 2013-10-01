# == Schema Information
# Schema version: 20130930184700
#
# Table name: boards
#
# *id*::         <tt>integer, not null, primary key</tt>
# *uid*::        <tt>string(255)</tt>
# *name*::       <tt>string(255)</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#--
# == Schema Information End
#++

class Board < ActiveRecord::Base
  #belongs_to :user
end
