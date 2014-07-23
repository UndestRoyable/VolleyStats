class DataController < ApplicationController
  respond_to :json

  def teams
    teams = Team.all.map {|t| {id: t.id, name: t.name}}
    respond_with teams
  end

  def save_match
    #.... save match here

    # TODO respond with id of the created match

    respond_with [{match_id: 5}]
  end
end
