class UsersController < ApplicationController

require "net/http"
require "uri"

  def signin
	render 'signin.html.erb'
  end

def create
	@token = params[:token]
	uri = ('http://loginza.ru/api/authinfo?token=') + @token
 	@result = Net::HTTP.get(URI(uri))
	loginza = @result.split('","')[0].split('":"')[1]
	@user = User.find_or_create_by_loginza(loginza)
  	session[:user_id] = @user.id
	#puts session[:user_name]
		if @user.name == nil
			render 'edit.html.erb'
			#redirect_to :action => :edit
		else	
			redirect_to :links
		end
  end

def edit
	@user=User.find(session[:user_id])
	@user.update_attributes(:name => params[:name])
	redirect_to :links
end

def index
	render 'signin.html.erb'
end

def exit
	session[:user_id] = 0 
#	render 'signin.html.erb'
	redirect_to :action => :signin
end

def show
		if User.exists?(params[:id])
			@user=User.find(params[:id])
			@active_links=@user.links.where(:active=>true)
		else redirect_to :action => :signin
	end
end

end
