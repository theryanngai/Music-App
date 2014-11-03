class Track < ActiveRecord::Base
	validates :name, :album_id, :track_type, presence: true
	belongs_to :album
	has_one(
		:band,
		through: :album,
		source: :band
	)
end
