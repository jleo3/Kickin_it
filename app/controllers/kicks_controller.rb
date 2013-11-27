class KicksController < ApplicationController
  # Currently, this method returns this error when I navigate here: 
  # "There was an error saving your kick. Sorry!" If you don't want your 
  # users to access it, you should take it out.
  def index
  end

  def show
    @kick = Kick.find(params[:id])
    @user = current_user.name
    respond_to do |format|
      format.html
      format.json { render json: @kick }
    end
  end

  def new
    @kick = Kick.new
  end

  def create
    # You can leverage your ActiveRecord associations to do some of this heavy 
    # lifting. @kick.user = @user should be all you need. Then if you want the 
    # @kick's username, it's just @kick.user.name
    @user = current_user
    kick_params = params.require(:kick).permit(:title, :description, :time, :location, :user_id,
                                               :latitude, :longitude,
                                               :name, :scale,
                                               :avatar, :user_avatar_file_name,:user_avatar,
                                               :filepicker_url, :filepicker_avatar_url)
    @kick = Kick.new(kick_params)
    @kick.user_id = @user.id
    @kick.username = @user.name
    @kick.user_avatar = @user.avatar
    @kick.filepicker_avatar_url = @user.filepicker_url

    if @kick.save
      redirect_to @kick  #shows that kick
    else
      render :index     #change this
    end
  end

  # GET /kicks/1/edit
  def edit
    @kick = Kick.find(params[:id])
  end

  # PUT /kicks/1
  # PUT /kicks/1.json
  def update
    @kick = Kick.find(params[:id])
    kick_params = params.require(:kick).permit(:title, :description, :time, :location, :user_id, :latitude, :longitude,
                                               :name, :scale, :avatar,
                                               :user_avatar, :filepicker_url, :filepicker_avatar_url)

    respond_to do |format|
      if @kick.update_attributes(kick_params)
        format.html { redirect_to @kick, notice: 'Kick was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kick.errors, status: :unprocessable_entity }
      end
    end
  end

  # In a RESTful world, this would live at kickin-it.com/users/#{user.id}/kicks
  # In other words, this logic would live in the #index method
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
    params.require('kick').permit(:title, :description, :time, :location, :user_id, :latitude, :longitude, :name, :scale, :avatar)
  end
end
