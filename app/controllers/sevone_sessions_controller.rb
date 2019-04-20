class SevoneSessionsController < ApplicationController
  before_action :set_sevone_session, only: [:show, :edit, :update, :destroy]

  # GET /sevone_sessions
  # GET /sevone_sessions.json
  def index
    @sevone_sessions = SevoneSession.all
  end

  # GET /sevone_sessions/1
  # GET /sevone_sessions/1.json
  def show
  end

  # GET /sevone_sessions/new
  def new
    @sevone_session = SevoneSession.new
  end

  # GET /sevone_sessions/1/edit
  def edit
  end

  # POST /sevone_sessions
  # POST /sevone_sessions.json
  def create
    @sevone_session = SevoneSession.new(sevone_session_params)

    respond_to do |format|
      if @sevone_session.save
        format.html { redirect_to @sevone_session, notice: 'Sevone session was successfully created.' }
        format.json { render :show, status: :created, location: @sevone_session }
      else
        format.html { render :new }
        format.json { render json: @sevone_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sevone_sessions/1
  # PATCH/PUT /sevone_sessions/1.json
  def update
    respond_to do |format|
      if @sevone_session.update(sevone_session_params)
        format.html { redirect_to @sevone_session, notice: 'Sevone session was successfully updated.' }
        format.json { render :show, status: :ok, location: @sevone_session }
      else
        format.html { render :edit }
        format.json { render json: @sevone_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sevone_sessions/1
  # DELETE /sevone_sessions/1.json
  def destroy
    @sevone_session.destroy
    respond_to do |format|
      format.html { redirect_to sevone_sessions_url, notice: 'Sevone session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sevone_session
      @sevone_session = SevoneSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sevone_session_params
      params.require(:sevone_session).permit(:session_name, :session_id, :object_name, :object_id, :device_name, :device_id, :device_elemets)
    end
end
