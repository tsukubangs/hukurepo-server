class Visualized::GraphsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def show
    @graph_data = {}
    Problem.counts_per_day(@graph_data)
  end
end
