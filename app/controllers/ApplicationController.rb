require './config/environment'
require 'sinatra/base'
require 'rack-flash'
require 'pry'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "study_and_test_secret"
  end

  get '/' do
    redirect to '/tests' if logged_in?
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
