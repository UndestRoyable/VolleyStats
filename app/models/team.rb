class Team < ActiveRecord::Base
  belongs_to :coach
  has_many :players
end
