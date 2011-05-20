class Reply < ActiveRecord::Base
  belongs_to :message
   attr_accessible :body,:message_id, :user_id, :sender_id, :subject
   
end
