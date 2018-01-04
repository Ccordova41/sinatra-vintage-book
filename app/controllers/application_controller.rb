require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if logged_in?
      @user = current_user
      redirect to "/users/#{@user.slug}"
    else
      erb :welcome
    end
  end

  get "/test" do
    current_user
    current_user
    current_user
    erb :welcome
  end

  helpers do

    def current_user
      @user = User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
