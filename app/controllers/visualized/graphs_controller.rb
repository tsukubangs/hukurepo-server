class Visualized::GraphsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def show
  end
end
