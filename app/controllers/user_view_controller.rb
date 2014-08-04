class UserViewController < ApplicationController
  layout false, :only => [:get_filtered]
  skip_before_filter  :verify_authenticity_token

  def team_players
    result = Player.
    joins(:team).
    select("players.id as id, players.first_name || ' ' || players.last_name as name, teams.id as team_id, teams.name as team_name")
    render json:result
  end

  def view
    @match = Match.find(params[:match_id])
  end

  def filter

    @filter_name = params[:filter_name]
    if(!(@filter_name == "player" || @filter_name == "range" || @filter_name == "team"))
      render json:{not_existing:true}
      return
    end

    if(@filter_name == "player")
      @angular_app = 'stats'

      @angular_controller = "user_view"
    end
  end

  def get_filtered
    filter = params[:filter]

    additional = ""
    additional_join = ""
    criteria = ""
    puts params
    if(filter == "player")
      @angular_app = 'stats'

      @angular_controller = "user_view"
      n = params[:data][:player].split(' ')
      player = Player.where(first_name:n[0], last_name:n[1]).first
      additional_join = "left outer join players p on p.team_id = host.id left outer join players pp on pp.team_id = guest.id"
      criteria = "p.id = #{player.id} or pp.id = #{player.id}"
    elsif(filter=="range")
      if(params[:data][:from][:date] != "")
        f = DateTime.strptime(params[:data][:from][:date], "%d/%m/%Y")
        hour = params[:data][:from][:hour].to_i
        minute = params[:data][:from][:minute].to_i
        from = DateTime.new(f.year,f.month,f.day,hour,minute)
        criteria += "matches.date >= '#{from}'"
      end
      if(params[:data][:to][:date] != "")
        t = DateTime.strptime(params[:data][:to][:date], "%d/%m/%Y")

        hour = params[:data][:to][:hour].to_i
        minute = params[:data][:to][:minute].to_i
        to = DateTime.new(t.year,t.month,t.day,hour,minute)
        if(criteria != "")
          criteria += " and "
        end
        criteria += "matches.date <= '#{to}'"
      end
      additional = ", matches.date"
    elsif(filter == "team") 
      criteria = "guest.id = #{params[:data][:team]} or host.id = #{params[:data][:team]}"
      additional = ", matches.date"
    end

    @filtered_result = Match.
    joins(:match_host).
    joins(:match_guest).
    joins("left outer join teams as host on match_hosts.team_id = host.id").
    joins("left outer join teams as guest on match_guests.team_id = guest.id").
    joins("#{additional_join}").
    select("matches.id, host.name as host_name, guest.name as guest_name #{additional}").
    where(criteria).uniq
  end

  def select
  end
end
