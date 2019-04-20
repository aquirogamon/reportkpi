class IprannetQosegressinterfacesController < ApplicationController
  before_action :set_iprannet_qosegressinterface, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /iprannet_qosegressinterfaces
  # GET /iprannet_qosegressinterfaces.json

  def index
    @search = IprannetQosegressinterface.where(created_at: (IprannetQosegressinterface.maximum(:created_at) - 20.minutes)..IprannetQosegressinterface.maximum(:created_at)).order("bps_max DESC").ransack(params[:q])
    @iprannet_qosegressinterfaces = @search.result.paginate(:page => params[:page], :per_page => 50)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    # Exportar en xls
    @iprannet_qosegressinterfaces_xls = IprannetQosegressinterface.where(created_at: (IprannetQosegressinterface.maximum(:created_at) - 20.minutes)..IprannetQosegressinterface.maximum(:created_at)).order("bps_max DESC")
    #@iprannet_qosegressinterfaces_all_csv = IprannetQosegressinterface.all

    respond_to do |format|
      format.html
      format.csv { send_data @iprannet_qosegressinterfaces_all_csv.to_csv }
      format.xls
    end
  end

  # GET /iprannet_qosegressinterfaces/1
  # GET /iprannet_qosegressinterfaces/1.json
  def show
    @start_date = params[:start].try(:to_date) || 3.days.ago.to_date
    @end_date = params[:end].try(:to_date) || Time.now
    range = (@start_date..@end_date)

    chart_device_port = IprannetQosegressinterface.where(device_port: @iprannet_qosegressinterface.device_port).order("created_at ASC").where(created_at: range)
    #@chard_discard_test = chart_device_port.pluck(:created_at, :queueId, :discard).map { |e| [ e[0].to_time, e[1], e[2] ] }.to_json.html_safe
    @chart_discard_1 = chart_device_port.where(queueId: 1).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_2 = chart_device_port.where(queueId: 2).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_3 = chart_device_port.where(queueId: 3).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_4 = chart_device_port.where(queueId: 4).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_5 = chart_device_port.where(queueId: 5).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_6 = chart_device_port.where(queueId: 6).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_discard_7 = chart_device_port.where(queueId: 7).pluck(:created_at, :discard).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_1 = chart_device_port.where(queueId: 1).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_2 = chart_device_port.where(queueId: 2).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_3 = chart_device_port.where(queueId: 3).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_4 = chart_device_port.where(queueId: 4).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_5 = chart_device_port.where(queueId: 5).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_6 = chart_device_port.where(queueId: 6).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_bps_max_7 = chart_device_port.where(queueId: 7).pluck(:created_at, :bps_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
  end

  # GET /iprannet_qosegressinterfaces/new
  def new
    @iprannet_qosegressinterface = IprannetQosegressinterface.new
  end

  # GET /iprannet_qosegressinterfaces/1/edit
  def edit
  end

  # POST /iprannet_qosegressinterfaces
  # POST /iprannet_qosegressinterfaces.json
  def create
    @iprannet_qosegressinterface = IprannetQosegressinterface.new(iprannet_qosegressinterface_params)

    respond_to do |format|
      if @iprannet_qosegressinterface.save
        format.html { redirect_to @iprannet_qosegressinterface, notice: 'Iprannet qosegressinterface was successfully created.' }
        format.json { render :show, status: :created, location: @iprannet_qosegressinterface }
      else
        format.html { render :new }
        format.json { render json: @iprannet_qosegressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /iprannet_qosegressinterfaces/1
  # PATCH/PUT /iprannet_qosegressinterfaces/1.json
  def update
    respond_to do |format|
      if @iprannet_qosegressinterface.update(iprannet_qosegressinterface_params)
        format.html { redirect_to @iprannet_qosegressinterface, notice: 'Iprannet qosegressinterface was successfully updated.' }
        format.json { render :show, status: :ok, location: @iprannet_qosegressinterface }
      else
        format.html { render :edit }
        format.json { render json: @iprannet_qosegressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iprannet_qosegressinterfaces/1
  # DELETE /iprannet_qosegressinterfaces/1.json
  def destroy
    @iprannet_qosegressinterface.destroy
    respond_to do |format|
      format.html { redirect_to iprannet_qosegressinterfaces_url, notice: 'Iprannet qosegressinterface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iprannet_qosegressinterface
      @iprannet_qosegressinterface = IprannetQosegressinterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def iprannet_qosegressinterface_params
      params.require(:iprannet_qosegressinterface).permit(:device, :port, :queueId, :bps_max, :discard, :discard_avg, :time, :comment, :weeks, :device_port, :device_portqueue, :service, :tx_provider_id)
    end
end
