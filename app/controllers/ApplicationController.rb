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
    erb :index
  end
end
