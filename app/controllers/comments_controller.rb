class CommentsController < ApplicationController

	def new
		@photo = Photo.find_by_id(params[:id])
		@comment = Comment.new
	end

	def create
		user = User.find_by(login: "#{session[:user]}")
		@comment = Comment.new(comment_params(params[:comment]))
		@comment.photo_id = params[:id]
		@comment.user_id = user.id
		@comment.date_time = DateTime.now
		@comment.comment = params[:comment][:comment]
		if @comment.save then
 			redirect_to(:controller => :photos, :action => :index, :id => user.id)
 		else
 			#need to get the photo in this function so we can render it
 			@photo = Photo.find_by_id(params[:id])
 			render(:action => :new)
 		end
	end

	private
	def comment_params(params)
		return params.permit(:comment, :photo_id, :user_id, :date_time)
	end

end
