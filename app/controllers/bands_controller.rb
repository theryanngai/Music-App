class BandsController < ApplicationController
	before_action :verify_logged_in

	def index
		@bands = Band.all
		render :index
	end

	def new
		@band = Band.new
		render :new
	end

	def create
		@band = Band.new(band_params)

		if @band.save
			flash[:alerts] = "You have successfully added #{@band.name}."
			redirect_to band_url(@band)
		else
			flash[:alerts] = @band.errors.full_messages
			render :new
		end
	end

	def edit
		set_current_band
		render :edit
	end

	def update
		set_current_band
		if @band.update_attributes(band_params)
			flash[:alerts] = "You have successfully updated #{@band.name}."
			redirect_to band_url(@band)
		else
			flash[:alerts] = @band.errors.full_messages
			render :edit
		end
	end


	def show
		set_current_band
		render :show
	end

	def destroy
		set_current_band
		if @band.delete
			flash[:alerts] = "You have successfully deleted #{@band.name}."
			redirect_to bands_url
		else
			flash[:alerts] = @band.errors.full_messages
			redirect_to band_url(@band)
		end
	end

	private

	def band_params
		params.require(:band).permit(:name)
	end

	def set_current_band
		@band = Band.find(params[:id])
	end

end
