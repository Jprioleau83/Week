class MicropostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def index
    @microposts = Micropost.find(:all)
  end
  def show
     @micropost= Micropost.find_by_id(params[:id])
     render 'microposts/show'
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
private

def authorized_user
  @micropost = Micropost.find(params[:id])
  redirect_to root_path unless current_user?(@micropost.user)
end
end