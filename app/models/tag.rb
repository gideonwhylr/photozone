class Tag < ActiveRecord::Base
	belongs_to :photo

	validates :photo_id, format: {
 		with: /.+/,
 		message: ": Photo ID cannot be blank"
 	}

 	validates :x_offset, format: {
 		with: /\d+/,
 		message: ": x offset cannot be blank"
 	}


 	validates :y_offset, format: {
 		with: /\d+/,
 		message: ": y offset cannot be blank"
 	}


 	validates :width, format: {
 		with: /\d+/,
 		message: ": width cannot be blank"
 	}

 	validates :height, format: {
 		with: /\d+/,
 		message: ": height cannot be blank"
 	}

 	validates :tagged_usr, format: {
 		with: /[a-z]+/,
 		message: ": tagged user cannot be blank"
 	}

 end