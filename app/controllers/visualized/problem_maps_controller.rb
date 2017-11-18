class Visualized::ProblemMapsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def index
    problems = Problem.all
    @hash = Gmaps4rails.build_markers(problems) do |problem, marker|
      marker.lat problem.latitude
      marker.lng problem.longitude
    end
  end
end
