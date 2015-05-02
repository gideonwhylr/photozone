class PhotosController < ApplicationController

	def index
		@user = User.find_by_id(params[:id])
		@photos = Photo.where("user_id == #{params[:id]}")

		@tag = Tag.new
		@tagees = User.all
		@tags = Hash.new
		for pic in @photos
			@tags[pic.id] = (Tag.where("photo_id == #{pic.id}"))
		end

		@comments = Hash.new
		for pic in @photos
			@comments[pic.id] = (Comment.where("photo_id == #{pic.id}"))
		end
	end

	def new
		@photo = Photo.new
		@user = User.find_by_login(session[:user])
	end

	def create
		filename = params[:photo][:photo].original_filename

		@photo = Photo.new(photo_params(params[:photo]))
		@photo.user_id = params[:id]
		@photo.date_time = DateTime.now
		@photo.file_name = filename
		if @photo.save then
			path = "#{Rails.root}/app/assets/images/#{filename}"
 			File.open(path, "wb") { |file| file.write(params[:photo][:photo].read)}
 			redirect_to(:controller => :photos, :action => :index, :id => params[:id])
 		else
 			@photo = Photo.new
 			render(:action => :new)
 		end
	end


	def photo_params(params)
		return params.permit(:first_name, :last_name, :login)
	end

	def create_tag
		@tag = Tag.new(tag_params(params[:tag]))
		@tag.tagged_usr = params[:tag][:tagged_usr]
		@tag.photo_id = params[:tag][:photo_id]
		@tag.x_offset = params[:tag][:x_offset]
		@tag.y_offset = params[:tag][:y_offset]
		@tag.width = params[:tag][:width]
		@tag.height = params[:tag][:height]
		if @tag.save then 
			redirect_to(:controller => :photos, :aciton => :index, :id => params[:id])
		else
			@user = User.find_by_id(params[:id])
			@photos = Photo.where("user_id == #{params[:id]}")
			@tagees = User.all
			@tags = Hash.new
			for pic in @photos
				@tags[pic.id] = (Tag.where("photo_id == #{pic.id}"))
			end

			@comments = Hash.new
			for pic in @photos
					@comments[pic.id] = (Comment.where("photo_id == #{pic.id}"))
			end
			render(:action => :index, :id => params[:id])
		end

	end

	def tag_params(params)
		return params.permit(:photo_id, :x_offset, :y_offset, :width, :height, :tagged_usr)
	end





end
