require_relative "../services/weather_service"

class MainController < ApplicationController

  def index
    @name = params[:name]
    # Uncomment and pass a parameter to the get function
    @w = WeatherService.get(params[:city])
    if @w
      @temperature = (9/5)*(@w[:temperature] - 273) + 32
      if not City.all.key?(params[:city].to_sym)
        city = City.new(
          name: params[:city],
          landmark: "None because this city is trash",
          population: 0
        )
        city.save
      end
    end
  end

end
