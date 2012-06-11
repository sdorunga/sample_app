class SessionsController < ApplicationController

def new
end

def create
	user = User.find_by_email(params[:session][:email])
	if user && user.authenticate(params[:session][:password])
	#checks both if the user exists(is non-nill) and uses the authenticate method from has_secure_password which returns true or false
		sign_in user
		redirect_back_or user #changed from redirect_to
	else
		flash.now[:error] = "Invalid email/password combination!"
		#use flasn.now instead of just flash because simple flash
		#only reacts to to a redirect and not just a simple render
		#which makes the flash appear even on subsequent pages
		#
		#flash.now is designed to flash errors on rendered pages,
		#not on redirects
		render 'new'
	end
end

def destroy
	sign_out
	redirect_to root_path
end

end
