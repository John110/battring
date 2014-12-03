class TournamentsController < ApplicationController
  def index
  end

  def show
    @tournament = Tournament.find(params[:matching_id])
    if @tournament.participants.nil?
      return
    elsif @tournament.cards.nil?
      Tournament.new.setting(@tournament.participants,@tournament.id)
    else
      Tournament.new.progress(@tournament.cards,@tournament.id)
    end
  end

  def new
    @create_matching = Matching.find(params[:matching_id])
    @tournament = @create_matching.tournament.build
  end

  def update
  end

  private

  def project_params
    params[:project].permit(:title)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
