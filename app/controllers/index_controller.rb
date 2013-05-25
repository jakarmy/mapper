class IndexController < ApplicationController
	helper :trips

	skip_before_filter :check_token

	def index
		@trips = trips

		respond_to do |format|
			format.html
			format.json {render json: @trips}
		end
	end
end
