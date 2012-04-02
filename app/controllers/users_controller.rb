class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user]) #passes the params variable from the new view that are inputed in the form
  	if @user.save #if user can be saved it returns true, else it returns false
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #works without writing user_path
  	else
  		render 'new'
  	end
  end
end
