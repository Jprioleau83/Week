class MessagesController < ApplicationController
   before_filter :correct_user, :only => [:show]
  
  def index
    @user = User.find(params[:user_id])
     @title = @user.name
    @messages = @user.messages.paginate(:page => params[:page])
  
end
 
 def new
    @user = User.find(params[:user_id])
   
   
   
   
 end

  

 def create
   #@message = Message.find(params[:message_id])
   @user = User.find(params[:user_id])
    #@user = User.find_by_id(params[integerid])
    
    @message = @user.messages.build(params[:message])
     senderid = current_user
     
    @message.update_attributes(:sender_id => current_user.id)
     @message.update_attributes(:user_id => @user.id)

   if @message.save
      flash[:success] = "Message created!"
      redirect_to root_path
    else
     
      render 'pages/home'
    end
  end
  
  
   def destroy
     @message = Message.find(params[:id])
     @user = User.find(params[:user_id])
    if @message.destroy
     
    redirect_to @user
    else
     
     redirect_to  user_message_path(@user)
    end
  end
  
  def show
     @message = Message.find(params[:id])
     
     @user = User.find(params[:user_id])
      @title = "Message form #{@user.name} "
    
    
  end
  
 
  
  
  private
  
   def correct_user
    @message = Message.find(params[:id])
    @user = User.find(@message.user_id)
    redirect_to(root_path) unless @user == current_user
  end
  
  def admin_user
    redirect_to(root) unless current_user.admin?
  end

 
  

end
