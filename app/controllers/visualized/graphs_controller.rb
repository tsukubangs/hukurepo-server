class Visualized::GraphsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def show
  end

  def chart_data
    graph_data = {}
    period = params[:period]
    if period == "hour" then
      Problem.counts_per_hour(graph_data)
    elsif period == "day" then
      Problem.counts_per_day(graph_data)
    elsif period == "month" then
      Problem.counts_per_month(graph_data)
    end
    render json: graph_data
  end

  def countries_data
    render json: User.where.not(country_of_residence: nil).group(:country_of_residence).count
  end

  def generation_data
    render json: User.where.not(age: nil).group(:age).count
  end
end
