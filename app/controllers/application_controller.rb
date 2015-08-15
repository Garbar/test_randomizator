class ApplicationController < ActionController::Base
  before_filter :global_data
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def global_data
    @default_city = City.first
    @city = City.find_by_url(params[:city_url])
    if @city.nil?
      @city = @default_city
    end
  end
end
