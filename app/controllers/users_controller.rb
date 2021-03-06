class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    if logged_in?
      @users = User.all
      erb :"/users/index.html"
    else
      redirect to "/home"
    end
  end

  get "/signup" do
    if logged_in?
      redirect to "/users"
    else
      erb :"/users/new.html"
    end
  end

  post "/signup" do
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect to "/users/#{user.slug}"
    else
      redirect to "/signup"
    end
  end

  get "/login" do
    if !logged_in?
      erb :"/users/login.html"
    else
      redirect to "/users"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @user = User.find_by_id(session[:user_id])
      redirect to "/users/#{@user.slug}"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect to "/"
    else
      redirect to "/login"
    end
  end
  # GET: /users/5
  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show.html"
    else
      redirect to "/login"
    end
  end

  # DELETE: /users/5/delete
  delete "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    @user.delete
    redirect "/logout"
  end
end
