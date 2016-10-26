class SharedInfosController < ApplicationController
  before_action :set_shared_info, only: [:show, :edit, :update, :destroy]

  # GET /shared_infos
  # GET /shared_infos.json
  def index
    @shared_infos = SharedInfo.this_period
  end

  # GET /shared_infos/1
  # GET /shared_infos/1.json
  def show
  end

  # GET /shared_infos/new
  def new
    @shared_info = SharedInfo.new
  end

  # GET /shared_infos/1/edit
  def edit
  end

  # POST /shared_infos
  # POST /shared_infos.json
  def create
    @shared_info = SharedInfo.new(shared_info_params)

    respond_to do |format|
      if @shared_info.save
        format.html { redirect_to @shared_info, notice: '追加されました。' }
        format.json { render :show, status: :created, location: @shared_info }
      else
        format.html { render :new }
        format.json { render json: @shared_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shared_infos/1
  # PATCH/PUT /shared_infos/1.json
  def update
    respond_to do |format|
      if @shared_info.update(shared_info_params)
        format.html { redirect_to @shared_info, notice: '変更されました。' }
        format.json { render :show, status: :ok, location: @shared_info }
      else
        format.html { render :edit }
        format.json { render json: @shared_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shared_infos/1
  # DELETE /shared_infos/1.json
  def destroy
    @shared_info.destroy
    respond_to do |format|
      format.html { redirect_to shared_infos_url, notice: '削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shared_info
      @shared_info = SharedInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shared_info_params
      params.require(:shared_info).permit(:title, :owner, :body, :announce_date)
    end
end
