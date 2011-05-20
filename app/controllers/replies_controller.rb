class RepliesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
     @title = @user.name
    @messages = @user.messages.paginate(:page => params[:page])
  
end
 
 def new
    @user = User.find(params[:user_id])
    @message = Message.find(params[:message_id])
   @reply = Reply.new
   
   
 end

  

 def create
   #@message = Message.find(params[:message_id])
   @user = User.find(params[:user_id])
    #@user = User.find_by_id(params[integerid])
    
    @message = Message.find(params[:message_id])
   
    oldbody = @message.body
    newbody = params[:body]
   
    @message = @user.messages.build(params[:message])
     
     
    @message.update_attributes(:body => oldbody + "
     Reply from "+ current_user.name + 
     
     " :" + @message.body)
    
     @message.update_attributes(:sender_id => current_user.id)

   if @message.save
     
      #@message.update_attributes(:body => "#{oldbody} Reply: #{@message.body}")
      flash[:success] = "Message created!"
      redirect_to root_path
    else
     
      render 'pages/home'
    end
  end
  
  
   def destroy
     @reply = Reply.find(params[:id])
     
     @user = User.find(params[:user_id])
    if @reply.destroy
     
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
 
  

end
