class DataApiController < BaseApiController
	before_filter :find_project, only: [:create]
	respond_to :json

	def create
		@data = Datum.create(
			sensorModel: @json['sensorModel'],
			sensorType: @json['sensorType'],
			unit: @json['unit'],
			time: @json['time'],
			value: @json['value'],
			lat: @json['lat'],
			lng: @json['lng'],
			project_id: @project.id)
		if @data.save
			render json: @data
		else
			render nothing: true, status: :bad_request
		end
	end

	private
	def find_project
		@project = Project.find_by_name(params[:projectName])
		render nothing: true, status: :not_found unless @project.present?
		# @project.user == @user
	end
end
