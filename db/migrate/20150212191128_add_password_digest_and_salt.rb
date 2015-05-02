class AddPasswordDigestAndSalt < ActiveRecord::Migration
  def change

  	  	add_column :users, :password_digest, :string
  	  	add_column :users, :salt, :int

  		User.reset_column_information

  		User.all.each do |usr|
    		usr.password=(usr.login)
        usr.save
    	end
    		
    end

end
