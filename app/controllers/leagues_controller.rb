class LeaguesController < ApplicationController
  before_filter :require_user

  # GET /leagues
  # GET /leagues.xml
  def index
    @leagues = League.all(:conditions => "name != 'All Users'")
    @all_league = League.first(:conditions => "name = 'All Users'")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.xml
  def show
    @league = League.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.xml
  def new
    @league = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.xml
  def create
    @league = League.new(params.require(:league).permit(:name).merge(:admin_id => @current_user))

    if @league.save
      @league.add_user(@current_user, @league.password)
      redirect_to(main_index_path, :notice => 'League was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.xml
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params.require(:league).permit(:name))
        redirect_to(@league, :notice => 'League was successfully updated.')
      else
        render :action => "edit"
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.xml
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      redirect_to(leagues_url)
    end
  end
end
