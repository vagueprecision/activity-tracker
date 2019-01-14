class LandingController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]

	def index
    redirect_to dashboard_index_path if logged_in?

  end
end
