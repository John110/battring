class MatchingsController < ApplicationController
  before_action :set_matching, only: [:show, :edit, :update, :destroy]

  def index
    @matchings = Matching.where(project_id: params[:project_id])
    @project = Project.find(params[:project_id])
  end

  def show
    @matching = Matching.find(params[:id])
    if @matching.start < Time.now
      redirect_to project_matching_tournament_path(@matching.project_id, @matching.id)
    end
  end

  def new
    @project = Project.find(params[:project_id])
    @matching = @project.matchings.build
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @matching = @project.matchings.create(matching_params)
    @matching.title = @project.title
    @matching.owner = current_player.username
    if @matching.memo.include?("")
      @matching.memo = "なし"
    end
    @matching.save
    respond_to do |format|
      if @matching.save
        format.html { redirect_to project_matching_path(@matching.project_id, @matching.id), notice: '正常に大会が作成されました!' }
        format.json { render :show, status: :created, location: @matching }
        Tournament.new.create(@matching.id, @matching.start)
        Card.new.create(@matching.id)
      else
        format.html { render :new }
        format.json { render json: @matching.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @matching.memo.include?("")
      @matching.memo = "なし"
      @matching.save
    end

    respond_to do |format|
      if @matching.update(matching_params)
        format.html { redirect_to project_matching_path(@matching.project_id, @matching.id), notice: '大会を更新しました' }
        format.json { render :show, status: :ok, location: @matching }
      else
        format.html { render :edit }
        format.json { render json: @matching.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @matching.destroy
    respond_to do |format|
      format.html { redirect_to project_matchings_path(@matching.project_id), notice: 'Create matching was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_matching
    @matching = Matching.find(params[:id])
  end

  def matching_params
    params.require(:matching).permit(:name, :owner, :reguration, :limit, :start, :memo, :participant_id)
  end
end
