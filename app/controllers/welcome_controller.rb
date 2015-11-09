class WelcomeController < ApplicationController
  
  def index
    render :json => {:message => "This is welcome page"}
  end
  
  
end
