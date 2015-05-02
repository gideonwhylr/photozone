class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :tags

	def Photo.photo_search(query)
			result = Array.new
			for photo in Photo.all

				tags = Tag.where("photo_id == #{photo.id}")
				comments = Comment.where("photo_id == #{photo.id}")
				seen = Set.new

				for tag in tags
					if tag.tagged_usr.downcase.include? query.downcase
						if ! seen.include? photo.id
							result.push(photo)
							seen << photo.id
						end
					end
				end

				for comnt in comments
					if comnt.comment.downcase.include? query.downcase
						if ! seen.include? photo.id
							result.push(photo)
							seen << photo.id
						end
					end
				end

			end


	return result
	end

end
