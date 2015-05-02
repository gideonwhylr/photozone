class AddLoginAttribute < ActiveRecord::Migration
  def change
  	add_column :users, :login, :string

  	User.reset_column_information

  	User.all.each do |usr|
    	usr.login = usr.last_name.downcase
    	usr.save
    end
  end
end
