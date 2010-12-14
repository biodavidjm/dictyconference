class HomeController < ApplicationController
  def index
  end
  
  def agenda
       render :action => "agenda", :layout=> true  
  end

end
