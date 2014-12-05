class CardsController < ApplicationController
  def index
  end

  def show
    @card = Card.find(params[:matching_id])
    if @card.participants.nil?
      return
    elsif @card.cards.nil?
      card.new.setting(@card.participants,@card.id)
    end
    if !@card.cards.nil?
      card.new.progress(@card.cards,@card.id)
    end
  end

  def new
    @create_matching = Matching.find(params[:matching_id])
    @card = @create_matching.card.build
  end

  def update
    @card = Card.find(params[:matching_id])
    if @card.next.nil?
      @card.next = params[:page][:result]
      @card.player_a = nil
      @card.player_b = nil
      @card.save
    elsif !(@card.next.include?("#{params[:page][:result]}"))
      @card.next = "#{@card.next}#{params[:page][:result]} "
      @card.player_a = nil
      @card.player_b = nil
      @card.save
    end
    if @card.result
      p "pass"
      Tournament.new.second_progress(@card.id)
    elsif @card.book.nil?
      Tournament.new.second_progress(@card.id)
    end
    @card.save
    redirect_to project_matching_tournament_path(params[:project_id], params[:matching_id])
  end

  private

  def project_params
    params[:project].permit(:title)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
