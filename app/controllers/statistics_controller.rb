class StatisticsController < ApplicationController
  layout false, :only => [:add_game]

  before_filter :verify_scout
  before_filter :set_angular_app, only: [:match_data, :match_statistic]
  skip_before_filter  :verify_authenticity_token

  def match_data

  end

  def match_statistic
    match_id = params[:match_id]
    @match = Match.find(match_id)
  end

  def add_game
    @host = Team.find(params[:host_id])
    @guest = Team.find(params[:guest_id])
    @set = params[:set]
  end

  def save_match
    
      match = Match.find(params[:id])
      match.spectators = params[:spectators]
      host = match.host
      guest = match.guest
      params[:set].keys.each do |y|
        #create match_set_score
        set = MatchSetScore.create
        set.set_number = y.to_s.to_i
        
        set.match_id = params[:id]
        partial1 = params[:set][y].partial1.split("-").select{|x| x.to_i}
        partial2 = params[:set][y].partial2.split("-").select{|x| x.to_i}
        partial3 = params[:set][y].partial3.split("-").select{|x| x.to_i}
        host_partial_1 = partial1[0]
        host_partial_2 = partial2[0]
        host_partial_3 = partial3[0]
        guest_partial_1 = partial1[1]
        guest_partial_2 = partial2[1]
        guest_partial_3 = partial3[1]

        host["set#{y}_break1"] = host_partial_1
        host["set#{y}_break2"] = host_partial_2
        host["set#{y}_break3"] = host_partial_3

        guest["set#{y}_break1"] = guest_partial_1
        guest["set#{y}_break2"] = guest_partial_2
        guest["set#{y}_break3"] = guest_partial_3

        result = params[:set][y].result.split("-").select{|x| x.to_i}
        set.host_score = result[0]
        set.guest_score = result[1]

        set.duration = params[:set][y].duration
        
        params[:set][y][:players].keys.each do |p|
          #create player_set_score

          player_score = PlayerSetScore.new
          player_score.match_set_score_id = set.id
          player_score.player_id = p.to_s.to_i

          params[:set][y][:players][p].keys.each do |f|
            # data for player_set_score
              player_score[f]= params[:set][y][:players][p][f]
          end
          player_score.save
        end
        set.save
      end

      match.save
      host.save
      guest.save


  end

  def puts_keys(holder,nesting = 1)

    for i in holder.keys do
      if(i.to_s =="statistic")
        next 
      end
      puts "#{' '*nesting}#{i}" 
      if(holder[i].methods.include?(:keys))
        puts_keys(holder[i],nesting+1)
      end
    end

  end

  private
  def verify_scout
    if(current_scout.nil?)
      redirect_to "/login"
    end
  end

  def set_angular_app
    if current_scout.present?
      @angular_app = 'stats'

      action = params[:action]

      if(action == "match_data")
        @angular_controller = 'stats_controller'
      elsif(action == "match_statistic")
        @angular_controller = 'statistics_controller'
      else
        puts "DONT KNOW WHAT CONTROLLER TO USE FOR #{params[:action]}\n" * 5
      end
    end
  end
end
