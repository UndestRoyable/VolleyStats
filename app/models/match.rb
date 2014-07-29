class Match < ActiveRecord::Base
  belongs_to :match_host
  belongs_to :match_guest
  belongs_to :hall
  belongs_to :scout

  def host
  	return match_host.team
  end

  def guest
  	return match_guest.team
  end

  def first_referee
    return get_referee(self.first_referee_id)
  end

  def second_referee
    return get_referee(self.second_referee_id)
  end

  private
  def get_referee(id)
    if(id==nil|| id==0)
      return Referee.new
    else
      return Referee.find(id)
    end

  end
end
