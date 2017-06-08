module V1
  class ProblemsController < ApplicationController
    before_action :set_problem, only: [:show, :update, :destroy]

    # GET /problems
    def index
      @problems = Problem.all
      render json: @problems, each_serializer: V1::ProblemSerializer
    end

    # GET /problems/1
    def show
      render json: @problem, serializer: V1::ProblemSerializer, root: nil
    end

    # POST /problems
    def create
      @problem = Problem.new(problem_params)
      @problem.user = current_user
      if @problem.save
        render json: @problem, serializer: V1::ProblemSerializer, root: nil,
        status: :created, location: v1_problem_url(@problem)
      else
        render json: @problem.errors, status: :unprocessable_entity
      end
      publish_sox
    end

    # PATCH/PUT /problems/1
    def update
      if @problem.update(problem_params)
        render json: @problem, serializer: V1::ProblemSerializer, root: nil
      else
        render json: @problem.errors, status: :unprocessable_entity
      end
    end

    # DELETE /problems/1
    def destroy
      @problem.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_problem
        @problem = Problem.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def problem_params
        params.require(:problem).permit(:comment, :image, :latitude, :longitude)
      end

      def publish_sox
        # TODO: add validation to model
        @problem.comment ||= 'No comment'
        @problem.image ||= ''
        @problem.latitude ||= 0
        @problem.longitude ||= 0
        @problem.longitude ||= 0
        @problem.user.name ||= 'No name'
        @problem.user.age ||= 0
        @problem.user.gender ||= 'No gender'
        @problem.user.nationality ||= 'No nationality'

	rails_path = File::expand_path(File.expand_path('../../../../', __FILE__)) + '/'  
        if @problem.image.blank?
          image_path = rails_path +  "public/noimage.jpg"
        else
          image_path = rails_path + "public#{@problem.image.url}"
        end

        # imageはserverでrenameしているためエスケープの必要がない
        command = "java -jar "+  rails_path + "lib/jars/Pub.jar "
        command_params = "#{image_path} \"#{@problem.comment}\" #{@problem.latitude} #{@problem.longitude} \"#{@problem.user.name}\" #{@problem.user.age} \"#{@problem.user.gender}\" \"#{@problem.user.nationality}\""
        logger.debug ("#{command} #{command_params}")
        system("#{command} #{command_params}")
      end
  end
end
