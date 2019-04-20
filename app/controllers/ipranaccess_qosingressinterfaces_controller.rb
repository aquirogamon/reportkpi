class IpranaccessQosingressinterfacesController < ApplicationController
  before_action :set_ipranaccess_qosingressinterface, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /ipranaccess_qosingressinterfaces
  # GET /ipranaccess_qosingressinterfaces.json
  def index
    @search = IpranaccessQosingressinterface.where(created_at: (IpranaccessQosingressinterface.maximum(:created_at) - 20.minutes)..IpranaccessQosingressinterface.maximum(:created_at)).order("bps_max DESC").ransack(params[:q])
    @ipranaccess_qosingressinterfaces = @search.result.paginate(:page => params[:page], :per_page => 30)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    # Exportar en xls
    @ipranaccess_qosingressinterfaces_all_xls = IpranaccessQosingressinterface.where(created_at: (IpranaccessQosingressinterface.maximum(:created_at) - 20.minutes)..IpranaccessQosingressinterface.maximum(:created_at)).order("discard ASC")
    #@ipranaccess_qosingressinterfaces_all_csv = IpranaccessQosingressinterface.all

    respond_to do |format|
      format.html
      format.csv { send_data @ipranaccess_qosingressinterfaces_all_csv.to_csv }
      format.xls
    end
  end
  # GET /ipranaccess_qosingressinterfaces/1
  # GET /ipranaccess_qosingressinterfaces/1.json
  def show
    @start_date = params[:start].try(:to_date) || 3.days.ago.to_date
    @end_date = params[:end].try(:to_date) || Time.now
    range = (@start_date..@end_date)

    port_sap = IpranaccessQosingressinterface.where(device_sap: @ipranaccess_qosingressinterface.device_sap).order("created_at ASC").where(created_at: range)
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

  # GET /ipranaccess_qosingressinterfaces/new
  def new
    @ipranaccess_qosingressinterface = IpranaccessQosingressinterface.new
  end

  # GET /ipranaccess_qosingressinterfaces/1/edit
  def edit
  end

  # POST /ipranaccess_qosingressinterfaces
  # POST /ipranaccess_qosingressinterfaces.json
  def create
    @ipranaccess_qosingressinterface = IpranaccessQosingressinterface.new(ipranaccess_qosingressinterface_params)

    respond_to do |format|
      if @ipranaccess_qosingressinterface.save
        format.html { redirect_to @ipranaccess_qosingressinterface, notice: 'Ipranaccess qosingressinterface was successfully created.' }
        format.json { render :show, status: :created, location: @ipranaccess_qosingressinterface }
      else
        format.html { render :new }
        format.json { render json: @ipranaccess_qosingressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ipranaccess_qosingressinterfaces/1
  # PATCH/PUT /ipranaccess_qosingressinterfaces/1.json
  def update
    respond_to do |format|
      if @ipranaccess_qosingressinterface.update(ipranaccess_qosingressinterface_params)
        format.html { redirect_to @ipranaccess_qosingressinterface, notice: 'Ipranaccess qosingressinterface was successfully updated.' }
        format.json { render :show, status: :ok, location: @ipranaccess_qosingressinterface }
      else
        format.html { render :edit }
        format.json { render json: @ipranaccess_qosingressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ipranaccess_qosingressinterfaces/1
  # DELETE /ipranaccess_qosingressinterfaces/1.json
  def destroy
    @ipranaccess_qosingressinterface.destroy
    respond_to do |format|
      format.html { redirect_to ipranaccess_qosingressinterfaces_url, notice: 'Ipranaccess qosingressinterface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipranaccess_qosingressinterface
      @ipranaccess_qosingressinterface = IpranaccessQosingressinterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipranaccess_qosingressinterface_params
      params.require(:ipranaccess_qosingressinterface).permit(:device, :sap, :queueId, :bps_max, :discard, :discard_avg, :time, :comment, :weeks, :device_sap, :device_sapqueue, :service, :tx_provider_id)
    end
end
