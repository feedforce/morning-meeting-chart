class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all.order(:order)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    if can_create_graph?
      @goal = @goals.last
      @topic = @goal.topics.last
      @graph = Graph.create(@goal)
      @sum = @goal.progresses.sum(:amount)
    else
      redirect_to teams_path, alert: '目標や進捗を登録してからグラフを作成してください。'
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_path, notice: '新しいチームが作成されました。' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to teams_path, notice: 'チーム情報の更新に成功しました。' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'チームを削除しました。' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
    @entity = entity
    @goals = @team.goals.order(:date)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :goal, :entity, :order)
  end

  def can_create_graph?
    @goals.present? && @goals.last.progresses.present?
  end

  def entity
    return '(件)' if @team.orders?
    return '(円)' if @team.sales?
  end
end
