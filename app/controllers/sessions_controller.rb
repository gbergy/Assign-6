class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.where(email: params[:email]).first
		if @user && @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:notice] = "You are logged in"
			redirect_to user_path(@user)
		else
			flash[:alert] = "There was a problem"
			redirect_to root_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You were logged out"
		redirect_to root_path
	end

end
