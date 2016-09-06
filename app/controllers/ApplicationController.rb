require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  include Session_Checkable

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "study_and_test_secret"
  end

  get '/' do
    @num = 5
    if logged_in?
      redirect to '/tests'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end
end
