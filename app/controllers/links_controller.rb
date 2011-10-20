# encoding: utf-8

class LinksController < ApplicationController

  before_filter :set_current_user, :only => [ :new, :create ]
  
  def index
    
    redirect_to :action=>'new'
    
  end

  def new
    #создается поле запроса, для новой ссылки
    @link = Link.new

    @active_links = @user.links.where( :active => true )
    @nonactive_links = @user.links.where( :active => false )
    
  end

  def create

    #Валидация ссылки, на правильность формата и отсутствие матерков :)
    @link=Link.new(:link=>params[:link][:link])
    if @link.valid?!=true
              @active_links=@user.links.where(:active=>true)
              @nonactive_links=@user.links.where(:active=>false)
      render :action=>:new
      return
    end

    #Ищем, есть ли уже такой партнер в базе:
    partner_id=search_partner(params[:link][:link])

    if partner_id!=nil
      flash[:notice] = "Есть такой партнер, ссылка добавлена  в открытый доступ."
      active=true
    else
      active=false
      flash[:notice] = "Спасибо, такого партнера еще нет. Ссылка станет активной, после добавления модератором."
    end

    @link = @user.links.new(
       :link=>params[:link][:link],
       :active=>active,
       :partner_id=>partner_id)


    @link.save

    redirect_to :action=>:new

  end

  def search_partner(link)

    Partner.all.each do |p|
      return p.id if (link =~ Regexp.new("#{p.regex}"))!=nil

    end

    return nil #partner_id
  end

  def destroy
    @link=Link.find(params[:id])
    @link.destroy

    redirect_to :links
  end

end

