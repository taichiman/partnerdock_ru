class ClicksController < ApplicationController

  def create
 		if Link.exists?(params[:id])
   		@link=Link.find(params[:id])
   		puts @link.inspect
   		puts '@@@'
   		puts params[:id]
  		Click.create(:ip=>'100500', :link_id=>params[:id])
				redirect_to 'http://' + @link.link
  		else redirect_to :controller => :users, :action => :signin
		end

  end

end

