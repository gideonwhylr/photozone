class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.column :user_id,	:string
    	t.column :date_time,	:string
    	t.column :file_name,	:string

      	t.timestamps null: false
    end
  end
end
