class HomeController < ApplicationController
  def index
  end
  
  def agenda
       render :action => "agenda", :layout=> true  
  end
  def registration
       render :action => "registration", :layout=> true  
  end
  def transport
       render :action => "coming", :layout=> true  
  end
  def abstract
       render :action => "coming", :layout=> true  
  end
  def sponsors
       render :action => "sponsors", :layout=> true  
  end
end
