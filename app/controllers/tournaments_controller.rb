class TournamentsController < ApplicationController
  def index
  end

  def show
    @project = Project.find(params[:project_id])
    @tournament = Tournament.find(params[:matching_id])
    @card = Card.find(params[:matching_id])
    if @tournament.participants.nil?
      return
    elsif @tournament.cards.nil?
      Tournament.new.setting(@tournament.participants,@tournament.id)
    end
    if @tournament.cards && !@tournament.is_second_battle
      Tournament.new.first_progress(@tournament.id)
    elsif @card.result && @card.player_a.nil?
      Tournament.new.second_progress(@card.result,@tournament.id)
    end
  end

  def new
    @create_matching = Matching.find(params[:matching_id])
    @tournament = @create_matching.tournament.build
  end

  def create
  end

  private

  def project_params
    params[:project].permit(:title)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
