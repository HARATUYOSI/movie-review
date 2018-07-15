class CountriesController < ApplicationController
  def show
    @country = Country.find_by(id: params[:id])
    @countries = Country.all
    @movies = Movie.where(country_id: params[:id])
  end
end
