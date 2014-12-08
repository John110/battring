class MatchingsController < ApplicationController
  before_action :set_create_matching, only: [:show, :edit, :update, :destroy]

  def index
    @create_matchings = Matching.where(project_id: params[:project_id])
    @project = Project.find(params[:project_id])
  end

  def show
    @create_matching = Matching.find(params[:id])
    if @create_matching.start < Time.now
      redirect_to project_matching_tournament_path(@create_matching.project_id, @create_matching.id)
    end
  end

  def new
    @project = Project.find(params[:project_id])
    @create_matching = @project.matchings.build
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @create_matching = @project.matchings.create(create_matching_params)

    respond_to do |format|
      if @create_matching.save
        format.html { redirect_to project_matching_path(@create_matching.project_id, @create_matching.id), notice: 'Create matching was successfully created.' }
        format.json { render :show, status: :created, location: @create_matching }
        Tournament.new.create(@create_matching.id, @create_matching.start)
        Card.new.create(@create_matching.id)
      else
        format.html { render :new }
        format.json { render json: @create_matching.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @create_matching.update(create_matching_params)
        format.html { redirect_to project_matching_path(@create_matching.project_id, @create_matching.id), notice: 'Create matching was successfully updated.' }
        format.json { render :show, status: :ok, location: @create_matching }
      else
        format.html { render :edit }
        format.json { render json: @create_matching.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @create_matching.destroy
    respond_to do |format|
      format.html { redirect_to project_matchings_path(@create_matching.project_id), notice: 'Create matching was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_create_matching
    @create_matching = Matching.find(params[:id])
  end

  def create_matching_params
    params.require(:matching).permit(:name, :owner, :title, :reguration, :limit, :start, :memo, :participant_id)
  end
end
