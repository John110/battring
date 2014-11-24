class FavoritesController < ApplicationController
	def create
		@user = User.find(params[:user_id])
		@project = Project.find_by(title: params[:title])
		if @project.nil? || is_redundant_title?
			redirect_to user_path(@user.name)
		else
			@favorite = @user.favorites.create(title: params[:title], project_id: params[:project_id])
			redirect_to user_path(@user.name)
		end
		
	end

	# def destroy
	# 	@task = Task.find(params[:id])
	# 	@task.destroy
	# 	redirect_to project_path(params[:project_id])
	# end


	private


  def is_redundant_title?
    Favorite.exists?(user_id: @user.id, title: params[:title])
  end
end
