class SessionsController < ApplicationController

	def new
		@user = User.new

		render :new
	end

	def create
		found = User.find_by_credentials(user_params[:email],
			user_params[:password])

		if found
			@user = found
			flash.now[:alerts] = "You are logged in!"
			login_user!(@user)
		else
			@user = User.new(user_params)
			flash.now[:alerts] = "Bad Username/Password combination."
			render :new
		end
	end
	

	def destroy
		current_user.reset_session_token!
		session[:token] = nil
		flash[:alerts] = 'You have been logged out.'
		redirect_to new_session_url
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end
end
