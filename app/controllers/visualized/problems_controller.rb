class Visualized::ProblemsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  PER = 12
  def index
    @problems = Problem.with_posted_user_info.page(params[:page]).per(PER).order(created_at: :DESC)
  end

  def show
  end
end
