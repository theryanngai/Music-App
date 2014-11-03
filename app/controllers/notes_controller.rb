class NotesController < ApplicationController
	def create
		fail
		@note = Note.new(note_params)

		if @note.save
		end
	end



	private
	def note_params
		params.require(:note).permit(:track_id, :body)
	end
end
