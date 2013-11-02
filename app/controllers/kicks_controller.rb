class KicksController < ApplicationController
  def index
  end

  def show
    @kick = Kick.find(params[:id])
  end

  def new
    @kick = Kick.new
  end

  def create
    kick_params = params.require(:kick).permit(:title, :description, :time, :location, :user_id, :latitude, :longitude, :name)
    @kick = Kick.new(kick_params)
    @kick.user_id = current_user.id
    @kick.username = current_user.name
    if @kick.save
      redirect_to @kick  #shows that kick
    else
      render :index     #change this
    end
  end


  def mykicks
    @user = User.find_by_id(current_user.id)
    @kicks = @user.kicks
    respond_to do |format|
      format.html
      format.json { render json: @kicks }
    end
  end

  private

  def kick_params
    params.require('kick').permit(:title, :description, :time, :location, :user_id, :latitude, :longitude, :name)
  end
end
