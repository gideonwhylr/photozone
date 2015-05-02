class UsersController < ApplicationController

	def index
		@users = User.all
		@active_search_results = Array.new
	end

	def login

	end

	def post_login
		@user = User.find_by_login(params[:username])

		if (@user == nil) then
			flash[:notice] = "No matching user ID"
			render(:action => :login)
		elsif @user.password_valid?(params[:password]) then
			session[:user] = @user.login
			redirect_to(:controller => :users, :action => :index, :id => "#{@user.id}")
		else
			flash[:notice] = "Invalid password"
			render(:action => :login)
		end

	end

	def logout
		flash.delete(:notice)
		session.delete(:user)
		redirect_to(:controller => :users, :action => :login)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params(params[:user]))

		#If the passwords don't match, then the password virtual attribute
		#is stored as 'no_match'. This is used during validation.
		if params[:user][:password] != params[:user][:password_digest]
			params[:user][:password] = "no_match"
		end

		@user.first_name = params[:user][:first_name]
		@user.last_name = params[:user][:last_name]
		@user.login = params[:user][:login]
		puts params[:user][:password]
		@user.password=(params[:user][:password])
		if @user.save then
			redirect_to(:action => :login)
		else
			@user.password = ""
			@user.password_digest = ""
			render(:action => :new)
		end

	end

	def user_params(params)
		return params.permit(:first_name, :last_name, :login)
	end

	def search
		active_search_results = Array.new
		if params[:q] == ""
			render :json => {}
		else
			active_search_results = Photo.photo_search(params[:q])
			render :json => active_search_results
		end
	end

end
