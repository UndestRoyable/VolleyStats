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
    #.... save match here
    puts params
    # TODO respond with id of the created match
    match_id = 5
    render json: "statistics/#{match_id}"
  end
end
