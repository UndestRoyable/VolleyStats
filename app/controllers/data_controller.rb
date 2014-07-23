class DataController < ApplicationController
  respond_to :json

  def teams
    teams = Team.all.map {|t| {id: t.id, name: t.name}}
    respond_with teams
  end

  def players_of_team
    team_id = params[:team_id]
    players = Player.joins(:position).select("positions.name as position_name, players.first_name, players.last_name, players.number").where("players.team_id = #{team_id}")
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
  def save_match
    #.... save match here

    # TODO respond with id of the created match

    respond_with [{match_id: 5}]
  end
end
