class ManagerCreatesessionsController < ApplicationController

	before_action :authenticate_user!
	helper_method :create_session_manager
	before_action :authenticate_admin!

	def show
		if (params[:name_reflector] != nil) and (params[:ip_reflector] != nil) and (params[:accediandevice_id] != nil) and (params[:type_twamp] != nil)
			unless ManagerSession.id_endpoint(params[:name_reflector]).present?
				create_session_manager(params[:name_reflector],params[:ip_reflector],params[:accediandevice_id],params[:type_twamp])
				@name_reflector = params[:name_reflector]
				@name_session_af12 = Accediandevice.find(params[:accediandevice_id]).site_name + "_" + @name_reflector + "_AF12"
				@name_session_ef = Accediandevice.find(params[:accediandevice_id]).site_name + "_" + @name_reflector + "_EF"
				ManagerSession.create(name_session: @name_session_af12, dstEndpoint: @name_reflector, accediandevice_id: params[:accediandevice_id], ip_endpoint: params[:ip_reflector])
				ManagerSession.create(name_session: @name_session_ef, dstEndpoint: @name_reflector, accediandevice_id: params[:accediandevice_id], ip_endpoint: params[:ip_reflector])
				flash[:notice] = "Se crearon correctamente las Sesiones en AF12 y EF."	
				#render manager_createsessions_show_path
			else
		   	flash[:alert] = "Las sessiones ya están creadas, favor de revisar en el SevOne o ingesar en el link 'Ver las Sesiones'."
		   	redirect_to manager_createsessions_show_path
			end
		end
		rescue => e
   	flash[:error] = "Ingresar todos los campos para crear las Sesiones en AF12 y EF."
   	redirect_to manager_createsessions_show_path
	end

	private

		def create_session_manager(name_reflector,ip_reflector,accediandevice_id,type_twamp)
			ManagerSession.create_endpoint(name_reflector,ip_reflector,type_twamp)
			ManagerSession.create_session(name_reflector, Accediandevice.find(accediandevice_id).site_name)
		end
end
