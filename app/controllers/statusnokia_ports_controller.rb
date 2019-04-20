class StatusnokiaPortsController < ApplicationController
  before_action :set_statusnokia_port, only: [:show, :edit, :update, :destroy]

  # GET /statusnokia_ports
  # GET /statusnokia_ports.json
  def index
    @search = StatusnokiaPort.ransack(params[:q])
    @statusnokia_ports = @search.result.paginate(:page => params[:page], :per_page => 100)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    # Exportar en xls
    @statusnokia_ports_all = StatusnokiaPort.all
  end

  # GET /statusnokia_ports/1
  # GET /statusnokia_ports/1.json
  def show
  end

  # GET /statusnokia_ports/new
  def new
    @statusnokia_port = StatusnokiaPort.new
  end

  # GET /statusnokia_ports/1/edit
  def edit
  end

  # POST /statusnokia_ports
  # POST /statusnokia_ports.json
  def create
    @statusnokia_port = StatusnokiaPort.create(StatusnokiaPort.samstatusport_table)
    redirect_to '/statusnokia_ports'
  end

  # PATCH/PUT /statusnokia_ports/1
  # PATCH/PUT /statusnokia_ports/1.json
  def update
    respond_to do |format|
      if @statusnokia_port.update(statusnokia_port_params)
        format.html { redirect_to @statusnokia_port, notice: 'Statusnokia port was successfully updated.' }
        format.json { render :show, status: :ok, location: @statusnokia_port }
      else
        format.html { render :edit }
        format.json { render json: @statusnokia_port.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statusnokia_ports/1
  # DELETE /statusnokia_ports/1.json
  def destroy
    @statusnokia_port.destroy
    respond_to do |format|
      format.html { redirect_to statusnokia_ports_url, notice: 'Statusnokia port was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statusnokia_port
      @statusnokia_port = StatusnokiaPort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statusnokia_port_params
      params.require(:statusnokia_port).permit(:device, :port, :type_device, :configurespeed, :speed, :description, :status, :service_all)
    end
end
