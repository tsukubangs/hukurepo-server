class Visualized::GraphsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def show
    @all_user_count = User.posters.count
    @gender_ratio = User.gender_ratio
  end

  def chart_data
    graph_data = {}
    period = params[:period]
    if period == "hour" then
      Problem.counts_per_hour(graph_data, params[:date])
    elsif period == "day" then
      Problem.counts_per_day(graph_data, params[:date])
    elsif period == "month" then
      Problem.counts_per_month(graph_data, params[:date])
    end
    render json: graph_data
  end

  def countries_data
    render json: User.posters.where.not(country_of_residence: nil).group(:country_of_residence).count
  end

  def generation_data
    render json: User.posters.where.not(age: nil).group(:age).count
  end

end
