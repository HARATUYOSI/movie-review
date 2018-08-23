class ReleaseYearsController < ApplicationController
  def show
    @release_year = ReleaseYear.find_by(id: params[:id])
    @release_years = ReleaseYear.order(year: :desc)
    @movies = Movie.where(release_year_id: params[:id])
  end
end
