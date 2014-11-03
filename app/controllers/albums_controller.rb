class AlbumsController < ApplicationController
	before_action :verify_logged_in

	def new
		@album = Album.new
		render :new
	end

	def create
		@album = Album.new(album_params)

		if @album.save
			flash[:alerts] = "You have successfully 
							added the album '#{@album.name}'."
			redirect_to band_url(Band.find(@album.band_id))
		else
			flash[:alerts] = @album.errors.full_messages
			render :new
		end
	end

	def show
		set_current_album
		render :show
	end

	def edit
		set_current_album
		render :edit
	end

	def update
		set_current_album

		if @album.update_attributes(album_params)
			flash[:alerts] = "You have successfully updated #{@album.name}."
			redirect_to album_url(@album)
		else
			flash[:alerts] = @album.errors.full_messages
			render :edit
		end
	end

	def destroy
		set_current_album
		band = @album.band_id
		if @album.delete
			flash[:alerts] = "You have successfully deleted #{@album.name}."
			redirect_to band_url(band)
		else
			flash[:alerts] = @album.errors.full_messages
			redirect_to album_url(@album)
		end
	end



	private

	def album_params
		params.require(:album).permit(:name, :band_id, :recorded_at)
	end

	def set_current_album
		@album = Album.find(params[:id])
	end
end
