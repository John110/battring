class UsersController < ApplicationController
	def show
		# @user = User.find_by(:name => params[:id])
    @user = Player.find_by(:username => params[:id])
	end

	def new
		@favorite = Favorite.new
	end



end
