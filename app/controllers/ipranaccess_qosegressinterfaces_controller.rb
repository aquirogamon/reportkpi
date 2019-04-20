class IpranaccessQosegressinterfacesController < ApplicationController
  before_action :set_ipranaccess_qosegressinterface, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /ipranaccess_qosegressinterfaces
  # GET /ipranaccess_qosegressinterfaces.json
  def index
    @search = IpranaccessQosegressinterface.where(created_at: (IpranaccessQosegressinterface.maximum(:created_at) - 60.minutes)..IpranaccessQosegressinterface.maximum(:created_at)).order("discard DESC").ransack(params[:q])
    @ipranaccess_qosegressinterfaces = @search.result.paginate(:page => params[:page], :per_page => 25)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    # Exportar en xls
    @ipranaccess_qosegressinterfaces_all_xls = IpranaccessQosegressinterface.where(created_at: (IpranaccessQosegressinterface.maximum(:created_at) - 60.minutes)..IpranaccessQosegressinterface.maximum(:created_at)).order("discard DESC")
    #@ipranaccess_qosegressinterfaces_all_csv = IpranaccessQosegressinterface.all

    respond_to do |format|
      format.html
      format.csv { send_data @ipranaccess_qosegressinterfaces_all_csv.to_csv }
      format.xls
    end
  end

  # GET /ipranaccess_qosegressinterfaces/1
  # GET /ipranaccess_qosegressinterfaces/1.json
  def show
    @start_date = params[:start].try(:to_date) || 3.days.ago.to_date
    @end_date = params[:end].try(:to_date) || Time.now
    range = (@start_date..@end_date)

    port_sap = IpranaccessQosegressinterface.where(device_sap: @ipranaccess_qosegressinterface.device_sap).order("created_at ASC").where(created_at: range)
    #@chard_discard_test = port_sap.pluck(:created_at, :queueId, :discard).map { |e| [ e[0].to_time, e[1], e[2] ] }.to_json.html_safe

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
  # GET /ipranaccess_qosegressinterfaces/new
  def new
    @ipranaccess_qosegressinterface = IpranaccessQosegressinterface.new
  end

  # GET /ipranaccess_qosegressinterfaces/1/edit
  def edit
  end

  # POST /ipranaccess_qosegressinterfaces
  # POST /ipranaccess_qosegressinterfaces.json
  def create
    @ipranaccess_qosegressinterface = IpranaccessQosegressinterface.new(ipranaccess_qosegressinterface_params)

    respond_to do |format|
      if @ipranaccess_qosegressinterface.save
        format.html { redirect_to @ipranaccess_qosegressinterface, notice: 'Ipranaccess qosegressinterface was successfully created.' }
        format.json { render :show, status: :created, location: @ipranaccess_qosegressinterface }
      else
        format.html { render :new }
        format.json { render json: @ipranaccess_qosegressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ipranaccess_qosegressinterfaces/1
  # PATCH/PUT /ipranaccess_qosegressinterfaces/1.json
  def update
    respond_to do |format|
      if @ipranaccess_qosegressinterface.update(ipranaccess_qosegressinterface_params)
        format.html { redirect_to @ipranaccess_qosegressinterface, notice: 'Ipranaccess qosegressinterface was successfully updated.' }
        format.json { render :show, status: :ok, location: @ipranaccess_qosegressinterface }
      else
        format.html { render :edit }
        format.json { render json: @ipranaccess_qosegressinterface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ipranaccess_qosegressinterfaces/1
  # DELETE /ipranaccess_qosegressinterfaces/1.json
  def destroy
    @ipranaccess_qosegressinterface.destroy
    respond_to do |format|
      format.html { redirect_to ipranaccess_qosegressinterfaces_url, notice: 'Ipranaccess qosegressinterface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipranaccess_qosegressinterface
      @ipranaccess_qosegressinterface = IpranaccessQosegressinterface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipranaccess_qosegressinterface_params
      params.require(:ipranaccess_qosegressinterface).permit(:device, :sap, :queueId, :bps_max, :discard, :discard_avg, :time, :comment, :weeks, :device_sap, :device_sapqueue, :service)
    end
end
