class ManagerSessionsController < ApplicationController
  before_action :set_manager_session, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /manager_sessions
  # GET /manager_sessions.json
  def index
    @search = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 110.minutes)..ManagerSession.maximum(:created_at)).order("discard DESC").ransack(params[:q])
    @manager_sessions = @search.result.paginate(:page => params[:page], :per_page => 100)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    # Exportar en xls
    #@manager_sessions_all_xls = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 110.minutes)..ManagerSession.maximum(:created_at)).order("product_endpoint ASC").order("state_session DESC")
    #@manager_sessions_all_csv = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 110.minutes)..ManagerSession.maximum(:created_at)).order("product_endpoint ASC").order("state_session DESC")
    #@chart_sla_session = ManagerSession.all_sessions_sla.group_by{ |item| item[:name_sla_all] }.map{ |key, items| [key, items.count] }

    respond_to do |format|
      format.html
      format.csv { send_data @manager_sessions_all_csv.to_csv }
      format.xls
    end
  end

  # GET /manager_sessions/1
  # GET /manager_sessions/1.json
  def show
    @start_date = params[:start].try(:to_date) || 3.days.ago.to_date
    @end_date = params[:end].try(:to_date) || Time.now
    range = (@start_date..@end_date)

    ManagerSession.id_session_detail(params[:id])
    manager_session_name_session = ManagerSession.where(name_session: @manager_session.name_session).order("created_at ASC").where(created_at: range)
    @chart_dp50_p2r = manager_session_name_session.pluck(:created_at, :dp50_p2r).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_dp50_r2p = manager_session_name_session.pluck(:created_at, :dp50_r2p).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_delay_50 = manager_session_name_session.pluck(:created_at, :delay_50).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_dpmax_p2r = manager_session_name_session.pluck(:created_at, :dpmax_p2r).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_dpmax_r2p = manager_session_name_session.pluck(:created_at, :dpmax_r2p).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_delay_max = manager_session_name_session.pluck(:created_at, :delay_max).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_loss_p2r = manager_session_name_session.pluck(:created_at, :lossPercent_p2r).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    @chart_loss_r2p = manager_session_name_session.pluck(:created_at, :lossPercent_r2p).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }
    #@chart_delay_avg = manager_session_name_session.select(:id, :dp50_p2r, :dp50_r2p, :delay_50, :created_at).map { |e| [ e[0].strftime("%d/%m - %H:00"), e[1] ] }

  end

  # GET /manager_sessions/new
  def new
    @manager_session = ManagerSession.new
  end

  # GET /manager_sessions/1/edit
  def edit
  end

  # POST /manager_sessions
  # POST /manager_sessions.json
  def create
    @manager_session = ManagerSession.create(ManagerSession.all_sessions_endpoint)
    respond_to do |format|
      format.html { redirect_to manager_sessions_path }
      format.json { render :show, status: :created, location: @manager_session }
    end
    if @manager_session.count > 50000000
      @manager_session.first.delete
    end
  end

  # PATCH/PUT /manager_sessions/1
  # PATCH/PUT /manager_sessions/1.json
  def update
    respond_to do |format|
      if @manager_session.update(manager_session_params)
        format.html { redirect_to @manager_session, notice: 'Manager session was successfully updated.' }
        format.json { render :show, status: :ok, location: @manager_session }
      else
        format.html { render :edit }
        format.json { render json: @manager_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manager_sessions/1
  # DELETE /manager_sessions/1.json
  def destroy
    @manager_session.destroy
    respond_to do |format|
      format.html { redirect_to manager_sessions_url, notice: 'Manager session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def restart_session_id
    ManagerSession.id_session_restart(params[:manager_session_id])
    redirect_to manager_session_path(params[:manager_session_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager_session
      @manager_session = ManagerSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_session_params
      params.require(:manager_session).permit(:ip_endpoint, :name_endpoint, :product_endpoint, :state_endpoint, :type_endpoint, :capability, :port_endpoint, :tos_endpoint, :name_session, :sessionType, :sid, :dstEndpoint, :dstPort, :srcEndpoint, :srcIfc, :srcPort, :state_session, :interval_session, :tos_session, :payloadsize_session, :pps_session, :type_port, :sla, :status_device, :ip_interface_vcx, :dp50_p2r, :dpmax_p2r, :dpmin_p2r, :lossPercent_p2r, :dp50_r2p, :dpmax_r2p, :dpmin_r2p, :lossPercent_r2p, :delay_50, :delay_max, :delay_min, :lossPercent_p2r_p95, :lossPercent_r2p_p95, :delay_50_p95, :delay_max_p95, :events_delay50, :events_lossp2r, :events_lossr2p, :accediandevice_id, :tx_provider_id)
    end
end
