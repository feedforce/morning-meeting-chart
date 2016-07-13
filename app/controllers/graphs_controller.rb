class GraphsController < ApplicationController
  before_action :set_graph, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @graph.update(graph_params)
        format.html { redirect_to graphs_path, notice: 'チーム情報の更新に成功しました。' }
        format.json { render :show, status: :ok, location: @graph }
      else
        format.html { render :edit }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_graph
    @graph = Graph.find(params[:id])
  end

  def team_params
    params.require(:graph).permit(:yaxis)
  end
end
