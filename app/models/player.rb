class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :position
  belongs_to :country

  has_many :player_set_scores

  def statistics
    return self.player_set_scores
  end

  def matches
    return Match.
    joins("left outer join match_set_scores on match_set_scores.match_id = matches.id").
    joins("left outer join player_set_scores on player_set_scores.match_set_score_id = match_set_scores.id").
    where("player_set_scores.player_id = #{self.id}").uniq
  end

  def match_statistics(match)
    return self.statistics.where(match_id:match.id)
  end
end
