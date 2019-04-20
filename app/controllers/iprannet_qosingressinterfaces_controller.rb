class IprannetQosingressinterfacesController < ApplicationController
  before_action :set_iprannet_qosingressinterface, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /iprannet_qosingressinterfaces
  # GET /iprannet_qosingressinterfaces.json
  def index
    @search = IprannetQosingressinterface.where(created_at: (IprannetQosingressinterface.maximum(:created_at) - 20.minutes)..IprannetQosingressinterface.maximum(:created_at)).order("bps_max DESC").ransack(params[:q])
    @iprannet_qosingressinterfaces = @search.result.paginate(:page => params[:page], :per_page => 30)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    # Exportar en xls
    @iprannet_qosingressinterfaces_all_xls = IprannetQosingressinterface.where(created_at: (IprannetQosingressinterface.maximum(:created_at) - 20.minutes)..IprannetQosingressinterface.maximum(:created_at)).order("bps_max DESC")
    #@iprannet_qosingressinterfaces_all_csv = IpranaccessQosegressinterface.all

    respond_to do |format|
      format.html
      format.csv { send_data @iprannet_qosingressinterfaces_all_csv.to_csv }
      format.xls
    end
  end

  # GET /iprannet_qosingressinterfaces/1
  # GET /iprannet_qosingressinterfaces/1.json
  def show
    @start_date = params[:start].try(:to_date) || 3.days.ago.to_date
    @end_date = params[:end].try(:to_date) || Time.now
    range = (@start_date..@end_date)

    port_sap = IprannetQosingressinterface.where(device_port: @iprannet_qosingressinterface.device_port).order("created_at ASC").where(created_at: range)
    @chart_discard_1 = port_sap.where(queueId: 1).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_2 = port_sap.where(queueId: 2).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_3 = port_sap.where(queueId: 3).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_4 = port_sap.where(queueId: 4).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_5 = port_sap.where(queueId: 5).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_6 = port_sap.where(queueId: 6).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_7 = port_sap.where(queueId: 7).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_1 = port_sap.where(queueId: 1).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_2 = port_sap.where(queueId: 2).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_3 = port_sap.where(queueId: 3).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_4 = port_sap.where(queueId: 4).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_5 = port_sap.where(queueId: 5).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_6 = port_sap.where(queueId: 6).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_7 = port_sap.where(queueId: 7).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
  end

  # GET /iprannet_qosingressinterfaces/new
  def new
    @iprannet_qosingressinterface = IprannetQosingressinterface.new
  end

  # GET /iprannet_qosingressinterfaces/1/edit
  def edit
  end

  # POST /iprannet_qosingressinterfaces
  # POST /iprannet_qosingressinterfaces.json
  def create
    @iprannet_qosingressinterface = IprannetQosingressinterface.new(iprannet_qosingressinterface_params)

    respond_to do |format|
      if @iprannet_qosingressinterface.save
        format.html { redirect_to @iprannet_qosingressinterface, notice: 'Iprannet qosingressinterface was successfully created.' }
        format.json { render :show, status: :created, location: @iprannet_qosingressinterface }
      else
        format.html { render :new }
        format.json { render json: @iprannet_qosingressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /iprannet_qosingressinterfaces/1
  # PATCH/PUT /iprannet_qosingressinterfaces/1.json
  def update
    respond_to do |format|
      if @iprannet_qosingressinterface.update(iprannet_qosingressinterface_params)
        format.html { redirect_to @iprannet_qosingressinterface, notice: 'Iprannet qosingressinterface was successfully updated.' }
        format.json { render :show, status: :ok, location: @iprannet_qosingressinterface }
      else
        format.html { render :edit }
        format.json { render json: @iprannet_qosingressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iprannet_qosingressinterfaces/1
  # DELETE /iprannet_qosingressinterfaces/1.json
  def destroy
    @iprannet_qosingressinterface.destroy
    respond_to do |format|
      format.html { redirect_to iprannet_qosingressinterfaces_url, notice: 'Iprannet qosingressinterface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iprannet_qosingressinterface
      @iprannet_qosingressinterface = IprannetQosingressinterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def iprannet_qosingressinterface_params
      params.require(:iprannet_qosingressinterface).permit(:device, :port, :queueId, :bps_max, :discard, :discard_avg, :time, :comment, :weeks, :device_port, :device_portqueue, :service, :tx_provider_id)
    end
end
