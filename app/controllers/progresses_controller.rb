class ProgressesController < ApplicationController
  def index
    @progresses = Progress.where(team_id: params[:team_id])
  end
end
