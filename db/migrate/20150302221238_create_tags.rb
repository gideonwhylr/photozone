class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.column :photo_id,	:int
    	t.column :x_offset,	:float
    	t.column :y_offset,	:float
    	t.column :width, 	:float
    	t.column :height, 	:float
    	t.column :tagged_usr,	:string

      	t.timestamps null: false
    end
  end
end
