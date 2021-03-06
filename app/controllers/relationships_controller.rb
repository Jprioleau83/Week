class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    follower =  User.find_by_id(params[:followed_id])
    
    UserMailer.new_follower(@user, current_user.name).deliver
    
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    UserMailer.delete_follower(@user, current_user.name).deliver
  end
end