class MatchSetScore < ActiveRecord::Base
  belongs_to :match

  def number
    return self.set_number
  end
end
