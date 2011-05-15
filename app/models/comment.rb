class Comment < ActiveRecord::Base
  belongs_to :micropost
  attr_accessible :body, :micropost_id, :user_id
  
end
