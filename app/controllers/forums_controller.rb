class ForumsController < ApplicationController
  def index
    @forums = Forum.all
    @user = User.all 
  end

  def show
     @forum = Forum.find(params[:id]) 
     @user = User.find(params[:user_id])
  end

  def destroy
    @forum = Forum.find(params[:id])
    if @forum.destroy
      flash[:notice] = "Forum #{@forum.topic} deleted successfully!"
      redirect_to user_forums_path(@forum.user)
    else
      flash[:alert] = "There was a problem destroying #{@forum.topic}"
      redirect_to :back
    end
  end

  def new
    @forum = Forum.new
    @user = User.find(params[:user_id])
  end

  def create 
    @forum = Forum.new(forum_params)
    @forum.user_id = params[:user_id] #Associate forum to a specific user 
    if @forum.save
      flash[:notice] = "Forum was created
      successfully."
      redirect_to root_path
    else
      flash[:alert] = "There was a problem saving Forum."
      redirect_to new_user_forum_path(@forum.user)
    end
  end 

  def edit
    @forum = Forum.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update 
    @forum = Forum.find(params[:id]) 
    if @forum.update_attributes(forum_params)
      flash[:notice] = "Your Forum was updated
      successfully."
    else
      flash[:alert] = "There was a problem saving your
      Forum."
    end
    redirect_to user_forum_path(params[:user_id], @forum)
  end

  private

  def forum_params
    params.require(:forum).permit(:user_id, :body, :topic)
  end
end
