class DataController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token
  def teams
    teams = Team.all.map {|t| {id: t.id, name: t.name}}
    respond_with teams
  end

  def players_of_team
    team_id = params[:team_id]
    
    players = Player.joins(:position).
      select("positions.name as position_name, players.first_name || ' ' || players.last_name as name, players.number").
      where("players.team_id = #{team_id}").order("players.number")
    
    respond_with players
  end

  def cities
    cities = City.select("cities.name,cities.id")
    respond_with cities
  end

  def halls_of_city
    city_id = params[:city_id]
    halls = Hall.select("halls.name,halls.id").where("halls.city_id = #{city_id}")
    respond_with halls

  end

  def referees
    referees = Referee.select("(referees.first_name || ' ' || referees.last_name) as name ,referees.id")
    respond_with referees

  end

  def hours
    respond_with (8...22).step(1).to_a
  end

  def minutes
    respond_with (0...60).step(5).to_a
  end

  def save_match
    state = check_match_parameters
    missing = state[:missing]
    if(missing.length != 0)
      render json:{missing:missing}
      return
    end

    invalid = state[:invalid]
    if(invalid.length != 0)
      render json:{invalid:invalid}
      return
    end

    not_found = state[:not_found]
    if(not_found.length != 0)
      render json:{not_found:not_found}
      return
    end

    puts params
    # TODO respond with id of the created match
    match_id = 5
    render json: "statistics/#{match_id}"
  end

  private
  def check_match_parameters
    state = {}
    missing = []
    invalid = []
    not_found = []
    parameters = [
     :host_id,
     :guest_id,
     :city_id,
     :hall_id,
     :hours,
     :minutes,
     :date
    ]

    for parameter in parameters do 
      if(!params.has_key?(parameter))
        missing.push(parameter)
      elsif(params[parameter].blank?)
        invalid.push(parameter)
      elsif(!valid_parameter(parameter))
        invalid.push(parameter)
      elsif(parameter.to_s.end_with?("id"))
        if(model_not_existing(parameter))
          not_found.push(parameter)
        end
      end
    end

    r = []
    if(params.has_key?(:first_referee_id))
      r.push(:first_referee_id)
    end
    if(params.has_key?(:second_referee_id))
      r.push(:second_referee_id)
    end
    
    if(r.length == 0)
      missing.push(:referee)
    else
      for referee in r do 
        if(!valid_parameter(referee))
          invalid.push(referee)
        elsif(model_not_existing(referee))
          not_found.push(referee)
        end
      end
    end

    state[:missing] = missing
    state[:invalid] = invalid
    state[:not_found] = not_found

    return state
  end

  def valid_parameter(name)
    str = name.to_s
    last = str.split("_").last

    if(last == "id" || name == :minutes || name == :hours)
      return is_int(params[name])
    elsif name == :date
      begin
        Date.strptime(params[name], "%d/%m/%Y")
      rescue
        return false
      end

      return true
    end
    puts "UNKNOWN FIELD #{str}"
    return false
  end

  def is_int(str)
    if(str.class == Fixnum)
      return true
    end

    return str.to_s.to_i.to_s == str
  end

  def model_not_existing(name)
    id = params[name]
    if(id.class == String)
      id = id.to_i
    end

    if(name == :host_id || name == :guest_id)
      return Team.find(id) != nil
    elsif(name == :second_referee_id || name == :first_referee_id)
      return Referee.find(id) != nil
    elsif(name == :city_id)
      return City.find(id) != nil
    elsif(name == :hall_id)
      return Hall.find(id) != nil
    end

    puts "UNKNOWN MODEL #{name}"
    return false
  end
end
