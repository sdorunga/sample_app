class RelationshipsController < ApplicationController
	before_filter :signed_in_user

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_to do |format| #formerly just redirect_to @user
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user) #the current user function helps if an outsider tries to use it he can't as he can't fake the current_user
		respond_to do |format| #formerly just redirect_to @user
			format.html { redirect_to @user }
			format.js
		end		
	end
end