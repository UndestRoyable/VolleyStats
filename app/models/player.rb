class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :position
  belongs_to :country
end
