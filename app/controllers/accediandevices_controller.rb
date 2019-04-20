class AccediandevicesController < ApplicationController
  before_action :set_accediandevice, only: [:show, :edit, :update, :destroy]

  # GET /accediandevices
  # GET /accediandevices.json
  def index
    @accediandevices = Accediandevice.all
  end

  # GET /accediandevices/1
  # GET /accediandevices/1.json
  def show
  end

  # GET /accediandevices/new
  def new
    @accediandevice = Accediandevice.new
  end

  # GET /accediandevices/1/edit
  def edit
  end

  # POST /accediandevices
  # POST /accediandevices.json
  def create
    @accediandevice = Accediandevice.new(accediandevice_params)

    respond_to do |format|
      if @accediandevice.save
        format.html { redirect_to @accediandevice, notice: 'Accediandevice was successfully created.' }
        format.json { render :show, status: :created, location: @accediandevice }
      else
        format.html { render :new }
        format.json { render json: @accediandevice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accediandevices/1
  # PATCH/PUT /accediandevices/1.json
  def update
    respond_to do |format|
      if @accediandevice.update(accediandevice_params)
        format.html { redirect_to @accediandevice, notice: 'Accediandevice was successfully updated.' }
        format.json { render :show, status: :ok, location: @accediandevice }
      else
        format.html { render :edit }
        format.json { render json: @accediandevice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accediandevices/1
  # DELETE /accediandevices/1.json
  def destroy
    @accediandevice.destroy
    respond_to do |format|
      format.html { redirect_to accediandevices_url, notice: 'Accediandevice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accediandevice
      @accediandevice = Accediandevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accediandevice_params
      params.require(:accediandevice).permit(:site_name, :name_device, :type_device)
    end
end
