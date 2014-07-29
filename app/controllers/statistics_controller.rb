class StatisticsController < ApplicationController
  before_filter :verify_scout
  before_filter :set_angular_app, only: [:match_data, :match_statistic]

  def match_data
  end

  def match_statistic
    match_id = params[:match_id]
    @match = Match.find(match_id)
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

  def new_table
    @team = Team.find(params[:team_id])
    @set = params[:set]
  end
end
