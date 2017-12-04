class Visualized::ProblemsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def index
    @problems = Problem.joins(:user).select("problems.*, users.age AS user_age, users.gender AS user_gender")
  end
end
