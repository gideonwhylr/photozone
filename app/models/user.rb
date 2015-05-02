class User < ActiveRecord::Base
	has_many :photos
	has_many :comments

	def password
		@password
	end

	def password=(value)
		@password = value
		self.salt = Random.rand
		self.password_digest = Digest::SHA1.hexdigest(value + self.salt.to_s)
	end

	def password_valid?(candidate)
		return Digest::SHA1.hexdigest(candidate + self.salt.to_s) == self.password_digest
	end

	validates :first_name, format: {
 		with: /.+/,
 		message: " cannot be blank"
 	}

 	validates :last_name, format: {
 		with: /.+/,
 		message: " cannot be blank"
 	}

 	def validate_non_empty_password
 		#strip all the whitespace, then check to see length > 0
 		if @password && @password.gsub(/\s+/, "").length < 1 then
 			errors.add(:password, "Password must have one character")
 		end
 	end

 	def validate_username
 		if User.find_by_login(self.login) then
 			errors.add(:login, "This username already exists")
 		end
 	end

 	def validate_matching_passwords
 		if @password && @password == "no_match" then
 			errors.add(:password, "Passwords must match")
 		end
 	end

 	validate :validate_username, :on => :create
 	validate :validate_matching_passwords
 	validate :validate_non_empty_password
end
