class ProjectsApiController < BaseApiController
	before_filter :find_project, only: [:show]

	def index
		render json: Project.where('owner_id = ?', @user.id)
	end

	def show
		@project
	end

	private
	def find_project
		@project = Project.find_by_name(params[:projectName])
		render nothing: true, status: :not_found unless @project.present?
		# @project.user == @user
	end
end
