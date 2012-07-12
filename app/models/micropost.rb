class Micropost < ActiveRecord::Base
	attr_accessible :content
	
	belongs_to :user

	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	default_scope order: 'microposts.created_at DESC'

	def self.from_users_followed_by(user)
		followed_users_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		#user.followed_users_ids - was first alternative, replaced by SQL
		#where("user_id IN (:followed_users_ids) OR user_id = :user_id", followed_users_ids: followed_users_ids, user_id: user)
		where("user_id IN (#{followed_users_ids}) OR user_id = :user_id", user_id: user.id)
	end
end
