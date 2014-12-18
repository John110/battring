class ParticipantsController < ApplicationController
	before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
    @matching = Matching.find(params[:matching_id])
    @participants = @matching.participants
  end

  def new
    @matching = Matching.find(params[:matching_id])
    @participant = @matching.participants.build
  end

  def edit
  end

  def create
    @matching = Matching.find(params[:matching_id])
    @participant = @matching.participants.build(participant_params)
    respond_to do |format|
      if @participant.save
        format.html { redirect_to matching_participant_path(@matching, @participant), notice: "大会に参加しました!\n貴方の健闘を祈ります!" }
        format.json { render :show, status: :created, location: @participant }
        Tournament.new.update(@participant.name,params[:matching_id])
        # 3.times do |i| #デモ用プログラム
        #   @participant = @matching.participants.build(participant_params)
        #   @participant.name = "Nanasi#{i}"
        #   @participant.save
        #   Tournament.new.update(@participant.name,params[:matching_id])
        # end
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
    @matching = Matching.find(params[:matching_id])
    @participant = @matching.participants.find(params[:id])
  end

  def participant_params
    params.require(:participant).permit(:name, :matching_id)
  end
end
