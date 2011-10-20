require 'json'

#require 'yaml'

class UsersController < ApplicationController
  
  require "net/http"
  require "uri"

  def signin

    if session[ :user_id ].nil?    
      render 'signin.html.erb'
    else
      redirect_to :links
    end
    
  end

  def create
   
    @token = params[:token]
    uri = ('http://loginza.ru/api/authinfo?token=') + @token
    @result = Net::HTTP.get(URI(uri))
    
    @result = JSON::[] @result      
    @user = User.find_or_create_by_loginza( @result[ 'identity' ] )
    
    session[ :user_id ] = @user.id

    redirect_to :links
    
  end

  def exit
    
    reset_session
    redirect_to :action => :signin
    
  end
  
end

