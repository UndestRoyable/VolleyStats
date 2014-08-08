class MainController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def news
  end
  
  skip_before_filter  :verify_authenticity_token
  def create_mail
  
    VolleyMailer.send_email(params[:name],params[:email],params[:body], params[:category]).deliver
    render json: "Sent"

  end
end
