class PartnersController < ApplicationController
  def index
    @partners=Partner.all(:order=>'url')
  end

  def index_draft_links
		@links=Link.new
		@draft_links=@links.get_nonactive_links
  end

  def new
		@partner=Partner.new
		@draft_link=Link.find(params[:id])
  end

  def create
	@site = params[:site]
	@desc = params[:description]
	@regex = params[:regex]
	@n=0
	@links=Link.new
	#все неактивные еще линки (без партнеров)
	@draft_links=@links.get_nonactive_links

  # линки попавшие под regex
	$selected_links=[]

  #выберем линки, попадающие в веденный regex партнера
	@draft_links.each do |p|
		if (p.link =~ Regexp.new("#{@regex}"))!=nil
				then	$selected_links[@n]=p.link
					@n=@n+1

		end
	end
end

  # добавим партнера базу, и сделаем активными все линки нового партнера
  def add_link
	  @p = Partner.create(:url => params[:site], :description => params[:desc], :regex => params[:regex])

		$selected_links.each do |p|
			@l=Link.find_by_link(p)
			@l.partner_id = @p.id
			@l.active=true

			@l.save!
		end


	  redirect_to :action=>"index_draft_links"
  end

def edit
  @partner=Partner.find(params[:id])
end

def show
  @partner=Partner.find(params[:id])
end

def update
  @partner = Partner.find(params[:id])

  @partner.update_attributes(params[:partner])

  redirect_to :partners

end

def destroy
  puts @partners_links.inspect
  @l=Link.new
  @partners_links=@l.find_by_partner_id(params[:id])
  if @partners_links!=nil then
    @partners_links.each do |l|
      l.update(:active=>false, :partner_id=>nil)
    end
  end

  puts @partners_links.inspect


  @partner=Partner.find(params[:id])
#  @partner.destroy

  redirect_to :partners
end

end

