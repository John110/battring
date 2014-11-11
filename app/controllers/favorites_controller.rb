class FavoritesController < ApplicationController
	def create
		@user = User.find(params[:user_id])
		@project = Project.find_by(title: favorite_params[:title])
		if @project.nil?
			redirect_to user_path(@user.name)
    elsif is_redundant_title?
      redirect_to user_path(@user.name)
		else
			@favorite = @user.favorites.create(favorite_params.merge(project_id: @project.id))
			redirect_to user_path(@user.name)
		end
		
	end

	# def destroy
	# 	@task = Task.find(params[:id])
	# 	@task.destroy
	# 	redirect_to project_path(params[:project_id])
	# end


	private

	def favorite_params
		params[:favorite].permit(:title)
	end

  def is_redundant_title?
    Favorite.exists?(user_id: @user.id, title: favorite_params[:title])
  end
end
