class CpecacInterfacesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_cpecac_interface, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /cpecac_interfaces
  # GET /cpecac_interfaces.json
  def index
    @cpecac_interfaces = CpecacInterface.all
    #@cpecac_interfaces = CpecacInterface.where(created_at: (CpecacInterface.maximum(:created_at) - 30.minutes)..CpecacInterface.maximum(:created_at)).order("status DESC")

    respond_to do |format|
       format.html
       format.xls
       format.json
       format.pdf do
         render :pdf => "Reporte de Interfaces de CPE \##{CpecacInterface.maximum(:created_at).strftime("%U - %Y")}",
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

  # GET /cpecac_interfaces/1
  # GET /cpecac_interfaces/1.json
  def show
  end

  # GET /cpecac_interfaces/new
  def new
    @cpecac_interface = CpecacInterface.new
  end

  # GET /cpecac_interfaces/1/edit
  def edit
  end

  # POST /cpecac_interfaces
  # POST /cpecac_interfaces.json
  def create
    @cpecac_interface = CpecacInterface.new(cpecac_interface_params)

    respond_to do |format|
      if @cpecac_interface.save
        format.html { redirect_to @cpecac_interface, notice: 'Cpecac interface was successfully created.' }
        format.json { render :show, status: :created, location: @cpecac_interface }
      else
        format.html { render :new }
        format.json { render json: @cpecac_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpecac_interfaces/1
  # PATCH/PUT /cpecac_interfaces/1.json
  def update
    respond_to do |format|
      if @cpecac_interface.update(cpecac_interface_params)
        format.html { redirect_to @cpecac_interface, notice: 'Cpecac interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @cpecac_interface }
      else
        format.html { render :edit }
        format.json { render json: @cpecac_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpecac_interfaces/1
  # DELETE /cpecac_interfaces/1.json
  def destroy
    @cpecac_interface.destroy
    respond_to do |format|
      format.html { redirect_to cpecac_interfaces_url, notice: 'Cpecac interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    CpecacInterface.destroy(params[:cpecac_interface_ids])
    respond_to do |format|
      format.html { redirect_to cpecac_interfaces_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpecac_interface
      @cpecac_interface = CpecacInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpecac_interface_params
      params.require(:cpecac_interface).permit(:device, :port, :tx_max, :tx_per95, :rx_max, :rx_per95, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :weeks, :servicio)
    end
end
