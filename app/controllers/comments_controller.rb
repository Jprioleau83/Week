class CommentsController < ApplicationController
  before_filter :correct_user, :only => [:destroy]
   def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.create(params[:comment])
    commenterid = current_user
    @comment.update_attributes(:user_id => commenterid)
    redirect_to @micropost
   
  end

  def destroy
     @comment.destroy
    redirect_to @micropost
  end
  
  def edit
    
    @comment = Comment.find_by_id(params[:id])
    @micropost = Micropost.find_by_id(@comment.micropost_id)
  end
  
   def update
    
    @comment = Comment.find_by_id(params[:id])
     @micropost = Micropost.find_by_id(@comment.micropost_id)
    if @comment.update_attributes(params[:comment])
      flash[:success] = "Comment Updated!"
      redirect_to @micropost
    else
      @title = "Edit Comment"
      render 'edit'
    end
  end


private 
def correct_user
    @user = User.find_by_id(@comment.user_id)
    redirect_to(root_path) unless current_user?(@user)
  end
end
