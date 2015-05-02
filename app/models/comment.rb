class Comment < ActiveRecord::Base
	belongs_to :photo
	belongs_to :user

	validates :comment, format: {
 		with: /[a-z]+/,
 		message: ": cannot post empty comment"
 	}

end
