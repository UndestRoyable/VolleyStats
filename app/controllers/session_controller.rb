class SessionController < ApplicationController

  def login
    #FORM PAGE
  end

  def create #create new session, called from login form
    warden.authenticate!(:scope => resource_name, :recall => :login_fail)
    #redirect_to "/stats"
    redirect_to "/index"
  end
#http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
#statuses:
#200 == OK
#400 == BAD REQUEST
  def logout
    #render :json => 
    #status: #(200 / 400 / etc),
    #{ :success => #(true / false),
    #  :param1 => "",
    #  :param2 => {} 
    #}
    warden.authenticate!(:scope => resource_name, :recall => :logout_fail)
    redirect_to "/index"
  end

  private
  def login_fail #wrong credentials
    render status:401, 
    :json => {}
  end

  def logout_fail # already logged out
    redirect_to "/index"
  end
end
