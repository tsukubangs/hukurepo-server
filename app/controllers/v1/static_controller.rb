module V1
  class StaticController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    # get v1/run_smartphone_app
    def run_smartphone_app
      redirect_to "hukurepo://"
    end

  end
end
