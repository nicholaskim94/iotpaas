class BaseApiController < ApplicationController
	before_filter :parse_request, :authenticate_user_from_token!

	def parse_request
		@json = JSON.parse(request.body.read)
	end

	private
	def authenticate_user_from_token!
		if !@json['access_token']
			render nothing: true, status: :unauthorized
		else
			@user = nil
			User.find_each{ |u| @user = u if Devise.secure_compare(u.access_token, @json['access_token']) }
		end
	end
end
