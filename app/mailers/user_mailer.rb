class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    recipients user.email
    from       "sbeall@scires.com"
    subject    "Thank you for registering!"
    body       "This is a confirmation that you have registered for the twitter copy site.  Hope you enjoy!"
  end
  
  def new_follower(user, follower)
    
    recipients user.email
    from       "jprioleau@scires.com"
    subject    "You have a new follower"
    body        "#{follower} is now following you"
    
    
    
  end
  
  def delete_follower(user, follower)
    
    recipients user.email
    from       "jprioleau@scires.com"
    subject    "You have a new follower"
    body        "#{follower} is no longer following you"
    
    
    
  end
  
  
end
