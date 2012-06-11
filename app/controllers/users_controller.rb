class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :index, :update]
  before_filter :correct_user, only: [:edit, :update]

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

  def edit
    #@user = User.find(params[:id]) #no longer needed as it is applied by the correct_user session helper filter
  end

  def index
    @users = User.all
  end

  def update
    #@user = User.find(params[:id]) #no longer needed as it is applied by the correct_user session helper filter
    if @user.update_attributes(params[:user]) #updates and saves the attributes with the hash for attr_accesible attributes
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location #session helper to remember page attempted before loging in
        redirect_to signin_path, notice: "Please sign in." unless signed_in? #notice: is used instead of flash[:notice]= and passes
        #an option hash to redirect_to.(works for :error too, but not :success). This function redirects the user to the signin page
        #unless he is signed in. Thus it ensures authorization.
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
