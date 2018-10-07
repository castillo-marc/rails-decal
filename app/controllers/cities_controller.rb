class CitiesController < ApplicationController

  def view
    @city = params[:city]
  end

  def new
  end

  def create
    @name = params[:city]
    @landmark = params[:landmark]
    @population = params[:population]
    if (not @name.empty?) && (not @landmark.empty?) && (not @population.empty?)
      int = Integer(@population) rescue false
      if not int
        render plain: "Population must be an integer"
      else
        if City.all.key?(@name.to_sym)
          redirect_to controller: 'cities', action: 'view', city: @name
        else
          @w = WeatherService.get(@name)
          if @w
            @city = City.new(
              name: @name,
              landmark: @landmark,
              population: @population,
            )
            @city.save
            redirect_to controller: 'cities', action: 'view', city: @name
          else
            render plain: "That city has no weather information."
          end
        end
      end
    else
      render plain: "Not enough information to create a city."
    end
  end

  def update
    @name = params[:city]
    @landmark = params[:landmark]
    @population = params[:population]
    if not @name.nil?
      if City.all.key?(@name.to_sym)
        City.all[@name.to_sym].update({:landmark => @landmark, :population => @population})
        redirect_to controller: 'cities', action: 'view', city: @name
      end
    end
  end

end
