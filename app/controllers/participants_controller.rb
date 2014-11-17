class ParticipantsController < ApplicationController
	  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
    @create_matching = Matching.find(params[:matching_id])
    @participants = @create_matching.participants
  end

  def show
  end

  def new
    @create_matching = Matching.find(params[:matching_id])
    @participant = @create_matching.participants.build
  end

  def edit
  end

  def create
    @create_matching = Matching.find(params[:matching_id])
    @participant = @create_matching.participants.build(participant_params)
    respond_to do |format|
      if @participant.save
        format.html { redirect_to matching_participant_path(@create_matching, @participant), notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_participant
      @create_matching = Matching.find(params[:matching_id])
      @participant = @create_matching.participants.find(params[:id])
    end

    def participant_params
      params.require(:participant).permit(:name, :matching_id)
    end
end
