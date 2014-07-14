class Match < ActiveRecord::Base
  belongs_to :match_host
  belongs_to :match_guest
end
