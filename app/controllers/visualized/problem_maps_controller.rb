class Visualized::ProblemMapsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def index
    problems = Problem.where.not(latitude: nil, longitude: nil)
    @hash = Gmaps4rails.build_markers(problems) do |problem, marker|
      marker.lat problem.latitude
      marker.lng problem.longitude
      marker.infowindow render_to_string(partial: "visualized/infowindow", locals: {problem: problem})
      #マーカーをいじりたい時はここを変える
      # marker.picture({
      #             :url => "http://icon-rainbow.com/i/icon_03702/icon_037020_256.jpg",
      #             :width   => 32,
      #             :height  => 32
      #            })
      marker.title "TEST"
    end
  end
end
