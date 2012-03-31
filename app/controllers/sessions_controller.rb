class SessionsController < ApplicationController

def new
end

def create
	user = User.find_by_email(params[:session][:email])
	if user && user.authenticate(params[:session][:password])
	#checks both if the user exists(is non-nill) and uses the authenticate method from has_secure_password which returns true or false
	
	render 'new'
end

def destroy
end

end
