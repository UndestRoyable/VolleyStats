class SessionController < Devise::SessionsController
  skip_before_filter  :verify_authenticity_token
  skip_before_filter :authenticate_user!, :only => :create

  def login
    if current_scout != nil
      redirect_to(after_sign_in_path_for(nil))
    end
  end

  def after_sign_in_path_for(resource)
    "/match-data"
  end

  def after_sign_out_path_for(resource)
    "/index"
  end

  def create #create new session, called from login form
    render status:200, 
    :json => {}
    warden.authenticate!(:scope => resource_name)
    render status:200, 
    :json => {}
  end
#http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
#statuses:
#200 == OK
#400 == BAD REQUEST
  def logout
    warden.authenticate!(:scope => resource_name)
  end
end
