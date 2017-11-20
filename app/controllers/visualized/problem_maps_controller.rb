class Visualized::ProblemMapsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def index
    date = DateTime.now.beginning_of_day
    @post_counts = {
        day: Problem.by_day(date).count,
        month: Problem.by_month(date.month).count,
        year: Problem.by_year(date.year).count
    }

    problems = Problem.all
    @hash = Gmaps4rails.build_markers(problems) do |problem, marker|
      marker.lat problem.latitude
      marker.lng problem.longitude
    end
  end
end
