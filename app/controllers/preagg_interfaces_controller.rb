class PreaggInterfacesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_preagg_interface, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /preagg_interfaces
  # GET /preagg_interfaces.json
  def index
    @preagg_interfaces = PreaggInterface.where(PreaggInterface.arel_table[:created_at].gt(PreaggInterface.maximum(:created_at).to_date)).order("status DESC")
    @preagg_interfaces_all = PreaggInterface.all

    respond_to do |format|
       format.html
       format.xls
       format.json
       format.pdf do
         render :pdf => "Reporte de Interfaces de Pre-AGG Semana \##{PreaggInterface.maximum(:created_at).strftime("%U - %Y")}",
         :layout => 'pdf.html',
         :margin => {:top => 10, :bottom => 10, :left => 10, :right => 10},
         :orientation => 'landscape', # default , Landscape,
         :background => true,
         :encoding => "UTF-8", :type=>"application/pdf",
         :javascript_delay => 10000,
         #:disposition => "attachment",
         :viewport_size => "1280x1024",
         :page_size => "A4",
         :footer => { :right => 'Page [page] of [topage]',:font_size => 7 }
       end
    end

  end

  # GET /preagg_interfaces/1
  # GET /preagg_interfaces/1.json
  def show
  end

  # GET /preagg_interfaces/new
  def new
    @preagg_interface = PreaggInterface.new
  end

  # GET /preagg_interfaces/1/edit
  def edit
  end

  # POST /preagg_interfaces
  # POST /preagg_interfaces.json
  def create
    @preagg_interface = PreaggInterface.new(preagg_interface_params)

    respond_to do |format|
      if @preagg_interface.save
        format.html { redirect_to @preagg_interface, notice: 'Preagg interface was successfully created.' }
        format.json { render :show, status: :created, location: @preagg_interface }
      else
        format.html { render :new }
        format.json { render json: @preagg_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preagg_interfaces/1
  # PATCH/PUT /preagg_interfaces/1.json
  def update
    respond_to do |format|
      if @preagg_interface.update(preagg_interface_params)
        format.html { redirect_to @preagg_interface, notice: 'Preagg interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @preagg_interface }
      else
        format.html { render :edit }
        format.json { render json: @preagg_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preagg_interfaces/1
  # DELETE /preagg_interfaces/1.json
  def destroy
    @preagg_interface.destroy
    respond_to do |format|
      format.html { redirect_to preagg_interfaces_url, notice: 'Preagg interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    PreaggInterface.destroy(params[:preagg_interface_ids])
    respond_to do |format|
      format.html { redirect_to preagg_interfaces_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preagg_interface
      @preagg_interface = PreaggInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preagg_interface_params
      params.require(:preagg_interface).permit(:device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :weeks, :deviceindex, :provider_id)
    end
end
