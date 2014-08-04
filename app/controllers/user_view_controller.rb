class UserViewController < ApplicationController
  layout false, :only => [:get_filtered]

  def view
    @match = Match.find(params[:match_id])
  end

  def filter
    @id = params[:filter_id].to_i
    if(@id < 0 || @id > 3)
      render json:{not_existing:true}
      return
    end
  end

  def get_filtered

  end

  def select
  end
end
