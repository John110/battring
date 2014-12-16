class FavoritesController < ApplicationController
	def create
		@user = current_player
		@project = Project.find_by(title: params[:title])
		if @project.nil? || is_redundant_title?
			redirect_to user_path(@user.username)
		else
			@favorite = @user.favorites.create(title: params[:title], project_id: params[:project_id])
			redirect_to user_path(@user.username)
		end
		
	end

	def destroy
		@favorite = Favorite.find_by(player_id: current_player.id, project_id: params[:id])
		@favorite.destroy
		redirect_to user_path(current_player.username)
	end

	private

  def is_redundant_title?
    Favorite.exists?(player_id: @user.id, title: params[:title])
  end
end
