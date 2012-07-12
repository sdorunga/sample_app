# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password #works with password_digest column if it exists in the table
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed #makes rails look for followed_id
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower #makes rails look for follower_id
	before_save :create_remember_token
	#uses create_remember_token on the user due to "self" rather than creating a local variable
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true


  def feed
    Micropost.from_users_followed_by(self)
    #Micropost.where("user_id = ?", id) #? escapse the sql query to protect from sql injection; could be replaced with just "microposts", but it needs more than just the current user's feed
  end

  def following?(other_user)
  	relationships.find_by_followed_id(other_user.id)#both following? and follow use the implicit self to refer to the user
  end

  def follow!(other_user)
  	relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
  	relationships.find_by_followed_id(other_user.id).destroy
  end

	private

		def create_remember_token
			self.remember_token =SecureRandom.urlsafe_base64
		end
end
