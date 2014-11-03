class UsersController < ApplicationController
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:alerts] = "You have successfully created an account!"
			redirect_to bands_url
		else
			flash[:alerts] = @user.errors.full_messages
			render :new
		end
	end


	private

	def user_params
		params.require(:user).permit(:email, :password)
	end
end
