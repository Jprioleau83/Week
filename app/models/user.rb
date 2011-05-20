class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable :confirmable,
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :id, :name, :email, :password, :password_confirmation
  
  has_many :microposts, :dependent => :destroy
  
  has_many :messages, :dependent =>:destroy
                      
  #has_many :reverse_messages, :foreign_key => "reciever_id",
                 #     :dependent =>:destroy                    
                      
  
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
 
  
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
                                   
                                   
  has_many :following, :through => :relationships, :source => :followed                                 
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  #has_many :messaging, :through => :messages, :source => :sender                                 
  #has_many :messagers, :through => :reverse_messages, :source => :reciever
  
  
  
  
   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :format => { :with => email_regex }, 
                                       :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }
  
  
  
     
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
    

  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
 
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
end
