class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :new, :create, :password]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
 
    
 
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
   def index
    @title = "All users"
    @user = current_user
    @users = User.paginate(:page => params[:page])
    @users = User.search(params[:search])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
    @messages = Message.new
  end
  
   

  
  def edit 
    @title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated!"
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  

  
  private
  
   def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root) unless current_user.admin?
  end

end
