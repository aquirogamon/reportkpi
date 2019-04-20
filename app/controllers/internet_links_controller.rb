class InternetLinksController < ApplicationController
  before_action :set_internet_link, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_editor!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /internet_links
  # GET /internet_links.json
  def index
    @internet_links = InternetLink.all.order("time_activation ASC")
    #@internet_links = InternetLink.where(name_iru: "Fibra Optica").order("iru ASC")
    
    chart_internet_links = InternetLink.all
    @chart_all_tierone = chart_internet_links.group_by_year(:time_activation, format: "%Y").count
    @chart_telxius = chart_internet_links.where(name_iru: "Telxius").group_by_year(:time_activation, format: "%Y").count
    @chart_centurylink = chart_internet_links.where(name_iru: "Centurylink").group_by_year(:time_activation, format: "%Y").count
    @chart_tisparkle = chart_internet_links.where(name_iru: "Tisparkle").group_by_year(:time_activation, format: "%Y").count

    title_x = [["Month", "Bolivia", "Ecuador", "Madagascar", "Papua New Guinea", "Rwanda", "Average"]]
    data_y = [["2004/05", 165, 938, 522, 998, 450, 614.6], ["2005/06", 135, 1120, 599, 1268, 288, 682], ["2006/07", 157, 1167, 587, 807, 397, 623], ["2007/08", 139, 1110, 615, 968, 215, 609.4], ["2008/09", 136, 691, 629, 1026, 366, 569.6]]
    @chart_example = title_x + data_y
  end

  # GET /internet_links/1
  # GET /internet_links/1.json
  def show
  end

  # GET /internet_links/new
  def new
    @internet_link = InternetLink.new
  end

  # GET /internet_links/1/edit
  def edit
  end

  # POST /internet_links
  # POST /internet_links.json
  def create
    @internet_link = InternetLink.new(internet_link_params)

    respond_to do |format|
      if @internet_link.save
        format.html { redirect_to @internet_link, notice: 'Internet link was successfully created.' }
        format.json { render :show, status: :created, location: @internet_link }
      else
        format.html { render :new }
        format.json { render json: @internet_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /internet_links/1
  # PATCH/PUT /internet_links/1.json
  def update
    respond_to do |format|
      if @internet_link.update(internet_link_params)
        format.html { redirect_to @internet_link, notice: 'Internet link was successfully updated.' }
        format.json { render :show, status: :ok, location: @internet_link }
      else
        format.html { render :edit }
        format.json { render json: @internet_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /internet_links/1
  # DELETE /internet_links/1.json
  def destroy
    @internet_link.destroy
    respond_to do |format|
      format.html { redirect_to internet_links_url, notice: 'Internet link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internet_link
      @internet_link = InternetLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def internet_link_params
      params.require(:internet_link).permit(:iru, :tierone, :location_usa, :location_peru, :device, :port, :lacp, :id_iru, :id_tierone, :capacity, :observation, :time_activation, :time_iru, :time_rest, :status, :name_iru, :name_tierone)
    end
end
