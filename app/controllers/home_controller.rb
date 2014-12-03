class HomeController < ApplicationController
  def index
    if player_signed_in?
      redirect_to user_path(current_player.username)
    elsif
      render :layout => false
    end
  end
end
