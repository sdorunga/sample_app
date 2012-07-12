class Relationship < ActiveRecord::Base
	attr_accessible :followed_id

	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User" #Rails figures the names of the foreign key from the two symbols
											 #:follower and :follwed to make follower_id etc. Since neither have a model
											 #we specify the User class
	validates :follower_id, presence: true
	validates :followed_id, presence: true
end
