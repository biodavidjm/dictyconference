class HomeController < ApplicationController
  skip_before_filter :login_required
  
  def index
  end
  
  def agenda
  end

  def registration
  end

  def transport
  end

  def abstract
  end

  def sponsors
  end
  
end
