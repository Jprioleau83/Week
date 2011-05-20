class Message < ActiveRecord::Base
  belongs_to :user
   attr_accessible :body, :user_id, :sender_id, :subject
   has_many :replies, :dependent =>:destroy
end
