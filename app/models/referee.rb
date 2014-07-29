class Referee < ActiveRecord::Base
  belongs_to :contry
  def name
  	if(self.first_name.blank?||self.last_name.blank?)
  		return ""
  	end
  return first_name + " "+ last_name
  end


end
