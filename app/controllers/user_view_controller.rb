class UserViewController < ApplicationController
  layout false, :only => [:filter]


  def view
    @match = Match.find(params[:match_id])
  end

  def filter
    if(id < 0 || id > 3)
      render json:{not_existing:true}
      return
    end
  end

  def get_filtered

  end

  def select
  end
end
