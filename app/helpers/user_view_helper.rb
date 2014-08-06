module UserViewHelper

def getEfficiency(field,player_score)

   value = 0

    if(field == 'won_lost')
    
      value = (player_score.points_total) + (player_score.block_points)
    
    elsif (field == 'attack_efficiency')
    
       errors = (player_score.attack_errors)+(player_score.attack_blocks)
       total = (player_score.attack_total)

      value = errors / Float(total)
      if(total == errors)
        value = 0
      elsif(total === 0 && errors > 0)
        value = 0
      elsif(total > 0 && errors === 0)
        value = 100
      elsif(errors === 0 && total === 0)
        value = 0
      elsif(errors > total)
        value = 0
      else 
        value = 100 - (value * 100).to_i
      end

    elsif (field == 'reception_efficiency')
    
       errors = (player_score.reception_errors)
       total = (player_score.reception_total)

      value = errors / Float(total)
      if(total == errors)
        value = 0
        
      elsif(total === 0 && errors > 0)
        value = 0 
        
      elsif(total > 0 && errors === 0)
        value = 100
        
      elsif(errors === 0 && total === 0)
        value = 0
        
      elsif(errors > total)
        value = 0
        
      else 
        
        value = 100 - (value * 100).to_i
        
      end
    else 
      puts("Unhandled field " + field)
    end
    
    return value
  end
end

