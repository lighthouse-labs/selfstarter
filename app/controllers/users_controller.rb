class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create 
		@user = User.new(user_params)
		if @success = @user.save
			UserMailer.registration_confirmation(@user).deliver
		end
	end

	protected 

	def user_params
		params.require(:user).permit(:email, :first_name, :last_name)
	end

end