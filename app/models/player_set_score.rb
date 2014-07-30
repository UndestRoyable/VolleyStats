class PlayerSetScore < ActiveRecord::Base
  belongs_to :match_set_score
  belongs_to :player
end
