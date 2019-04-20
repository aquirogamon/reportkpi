class IpranedgeInterfacesController < ApplicationController
  before_action :set_ipranedge_interface, only: [:show, :edit, :update, :destroy]

  # GET /ipranedge_interfaces
  # GET /ipranedge_interfaces.json
  def index
    @ipranedge_interfaces = IpranedgeInterface.where(IpranedgeInterface.arel_table[:created_at].gt(IpranedgeInterface.maximum(:created_at).to_date)).order("status DESC").paginate(:page => params[:page], :per_page => 200)
    @ipranedge_interfaces_all = IpranedgeInterface.all

    respond_to do |format|
       format.html
       format.xls
       format.pdf do
         render :pdf => "Reporte Interfaces de IPRan Edge - " + IpranedgeInterface.last.created_at.strftime("%d/%m/%Y %H:%M:%S"),
         :layout => 'pdf.html',
         :margin => {:top => 10, :bottom => 10, :left => 10, :right => 10},
         :orientation => 'landscape', # default , Landscape,
         :background => true,
         :encoding => "UTF-8", :type=>"application/pdf",
         :javascript_delay => 10000,
         #:disposition => "attachment",
         :viewport_size => "1280x1024",
         :page_size => "a4",
         :footer => { :right => 'Page [page] of [topage]',:font_size => 7 }
       end
    end
  end

  # GET /ipranedge_interfaces/1
  # GET /ipranedge_interfaces/1.json
  def show
    @start_date = params[:start].try(:to_date) || 20.weeks.ago.to_date
    @end_date = params[:end].try(:to_date) || Time.now
    range = (@start_date..@end_date)

    port = IpranedgeInterface.where(deviceindex: @ipranedge_interface.deviceindex).order("created_at ASC").where(created_at: range)
    @chart_port = port.pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%U-%Y"), e[1] ] }
  end

  # GET /ipranedge_interfaces/new
  def new
    @ipranedge_interface = IpranedgeInterface.new
  end

  # GET /ipranedge_interfaces/1/edit
  def edit
  end

  # POST /ipranedge_interfaces
  # POST /ipranedge_interfaces.json
  def create
    @ipranedge_interface = IpranedgeInterface.new(ipranedge_interface_params)

    respond_to do |format|
      if @ipranedge_interface.save
        format.html { redirect_to @ipranedge_interface, notice: 'Ipranedge interface was successfully created.' }
        format.json { render :show, status: :created, location: @ipranedge_interface }
      else
        format.html { render :new }
        format.json { render json: @ipranedge_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PaTCH/PUT /ipranedge_interfaces/1
  # PaTCH/PUT /ipranedge_interfaces/1.json
  def update
    respond_to do |format|
      if @ipranedge_interface.update(ipranedge_interface_params)
        format.html { redirect_to @ipranedge_interface, notice: 'Ipranedge interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @ipranedge_interface }
      else
        format.html { render :edit }
        format.json { render json: @ipranedge_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ipranedge_interfaces/1
  # DELETE /ipranedge_interfaces/1.json
  def destroy
    @ipranedge_interface.destroy
    respond_to do |format|
      format.html { redirect_to ipranedge_interfaces_url, notice: 'Ipranedge interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipranedge_interface
      @ipranedge_interface = IpranedgeInterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipranedge_interface_params
      params.require(:ipranedge_interface).permit(:devicea, :porta, :descriptiona, :egressRate, :speed, :gbpsrx, :gbpstx, :last_bps_max, :last_status, :bps_max, :status, :crecimiento, :time, :comment, :weeks, :deviceindex, :name_devicea, :deviceb, :portb, :name_deviceb, :provider_id)
    end
end
