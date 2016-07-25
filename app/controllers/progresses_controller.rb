class ProgressesController < ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_progress, only: [:edit, :update, :destroy]

  def index
    @graph = @team.graph(graph_params)
    @progresses = Progress.where(team_id: @team.id).order('start_date asc')
  end

  def new
    @start_date = last_monday
    @end_date = last_monday + 4
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      @progress.update(progress_params)
      topic_params.each_with_index do |param, index|
        topic = @progress.topics[index]
        if topic
          topic.update!(content: param.last)
        else
          @progress.topics.create(content: param.last) if param.last
        end
      end
    end
    redirect_to team_progresses_path(params[:team_id]), notice: '更新されました'
  rescue
    redirect_to edit_team_progress_path(params[:team_id]),  alert: '入力に不備があります'
  end

  def create
    ActiveRecord::Base.transaction do
      @progress = Progress.create!(progress_params)
      topic_params.each do |_key, val|
        @progress.topics.create!(content: val)
      end
    end
    redirect_to team_progresses_path(params[:team_id]), notice: '作成されました'
  rescue
    redirect_to new_team_progress_path(params[:team_id]),  alert: '入力に不備があります'
  end

  def destroy
    @progress.destroy
    respond_to do |format|
      format.html { redirect_to team_progresses_path(team_id: params[:team_id]), notice: '削除されました' }
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_progress
    @progress = Progress.find(params[:id])
  end

  def graph_params
    params.require(:graph).permit(:year,:month)
  rescue
    { year: Time.current.year, month: Time.current.month }
  end

  def progress_params
    params.require(:progress).permit(:amount, :start_date, :end_date).merge(team: Team.find(params[:team_id]))
  end

  def topic_params
    params.require(:topic).require(:content).permit('0', '1', '2')
  end

  def last_monday
    today = Date.today
    if today.wday > 1
      today - (today.wday - 1)
    else
      today - (8 - today.wday)
    end
  end
end
