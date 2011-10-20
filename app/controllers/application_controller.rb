require "ap"

class ApplicationController < ActionController::Base

  
  protect_from_forgery
  
  private
  
  def set_current_user
    unless session[ :user_id ]
      redirect_to :root
      false
    else
      @user ||= User.find( session[ :user_id ] )
      true      
    end
  end

end
