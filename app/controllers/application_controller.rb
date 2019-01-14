class ApplicationController < ActionController::Base
	before_action :authenticate_user

	def authenticate_user
		redirect_to root_path unless logged_in?
	end

	def logged_in?
		current_user.present?
	end
end
