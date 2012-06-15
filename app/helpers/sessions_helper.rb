module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		current_user = user
	end

	def signed_in?
		!current_user.nil? #checks if current user is not(=!) nill
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= user_from_remember_token
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
      unless signed_in?
        store_location #session helper to remember page attempted before loging in
        redirect_to signin_path, notice: "Please sign in." unless signed_in? #notice: is used instead of flash[:notice]= and passes
        #an option hash to redirect_to.(works for :error too, but not :success). This function redirects the user to the signin page
        #unless he is signed in. Thus it ensures authorization.
      end
    end

	def sign_out
		current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default) #Chooses default if return_to is nill
		clear_return_to
	end

	def store_location
		session[:return_to] = request.fullpath
	end

	private #can only be used from inside sessions helper, and not available to end-user

		def user_from_remember_token
			remember_token = cookies[:remember_token]
			User.find_by_remember_token(remember_token) unless remember_token.nil?
		end

		def clear_return_to
			session.delete(:return_to) 
		end
end
