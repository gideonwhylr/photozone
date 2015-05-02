class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.column :photo_id,	:string
    	t.column :user_id,	:string
    	t.column :date_time,	:string
    	t.column :comment,	:string

      	t.timestamps null: false
    end
  end
end
