class UsersController < ApplicationController
	def show
		@user = User.find_by(:name => params[:id])
	end

	def new
		@favorite = Favoite.new
	end



end
