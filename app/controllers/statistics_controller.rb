class StatisticsController < ApplicationController
  before_filter :verify_scout

  def match_data
  end

  def match_statistic
    match_id = params[:match_id]
  end

  private
  def verify_scout
    if(current_scout.nil?)
      redirect_to "/login"
    end
  end
end
