class TracksController < ApplicationController
	before_action :verify_logged_in

	def new
		@track = Track.new
		render :new
	end

	def create
		@track = Track.new(track_params)

		if @track.save
			flash[:alerts] = "You have successfully 
							added the track '#{@track.name}' 
							to the album '#{Album.find(@track.album_id).name}'."
			redirect_to album_url(Album.find(@track.album_id))
		else
			flash[:alerts] = @track.errors.full_messages
			render :new
		end
	end

	def show
		set_current_track
		render :show
	end

	def edit
		set_current_track
		render :edit
	end

	def update
		set_current_track

		if @track.update_attributes(track_params)
			flash[:alerts] = "You have successfully updated #{@track.name}."
			redirect_to track_url(@track)
		else
			flash[:alerts] = @track.errors.full_messages
			render :edit
		end
	end

	def destroy
		set_current_track
		album = @track.album_id
		if @track.delete
			flash[:alerts] = "You have successfully deleted #{@track.name}."
			redirect_to album_url(@track.album_id)
		else
			flash[:alerts] = @track.errors.full_messages
			redirect_to track_url(@track)
		end
	end




	private

	def track_params
		params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
	end

	def set_current_track
		@track = Track.find(params[:id])
	end

end
