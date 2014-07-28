class Match < ActiveRecord::Base
  belongs_to :match_host
  belongs_to :match_guest
  belongs_to :hall
  belongs_to :scout
end
