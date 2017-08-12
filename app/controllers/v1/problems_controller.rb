module V1
  class ProblemsController < ApplicationController
    before_action :set_problem, only: [:show, :update, :destroy]

    # GET /v1/problems
    def index
      @problems = Problem.all.order(updated_at: :desc)
      paginate

      render json: @problems, each_serializer: V1::ProblemSerializer
    end

    # GET /v1/users/1/problems
    def users
      @problems = Problem.where(user_id: params[:user_id]).order(updated_at: :desc)
      paginate

      render json: @problems, each_serializer: V1::ProblemSerializer
    end

    # GET /v1/problems/me
    # GET /v1/users/me/problems
    def me
      params[:user_id] = current_user.id
      users
    end

    # GET /v1/problems/1
    def show
      render json: @problem, serializer: V1::ProblemSerializer
    end

    # POST /v1/problems
    def create
      @problem = Problem.new(problem_params)
      @problem.user = current_user
      @problem.responses_seen = true # 返信がないときには既読フラグはtrue
      if @problem.save
        render json: @problem, serializer: V1::ProblemSerializer, root: nil,
        status: :created, location: v1_problem_url(@problem)
        slack_notify(slack_message)
        # publish_sox
      else
        render json: @problem.errors, status: :unprocessable_entity
      end

    end

    # PATCH/PUT /v1/problems/1
    def update
      if @problem.update(problem_params)
        render json: @problem, serializer: V1::ProblemSerializer, root: nil
      else
        render json: @problem.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/problems/1
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

      def paginate
        @problems = @problems.page(params[:page]).per(params[:per] ||= 5) if params[:page]
      end

      def slack_message
        <<-EOC
`新しい困りごとが投稿されました`
User ID:*#{@problem.user.id}*
Email:*#{@problem.user.email}*
Problem:*#{@problem.comment}*

EOC
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
        image_path =  rails_path + ( @problem.image.blank? ? "public/noimage.jpg" : "public#{@problem.image.url}" )

        command = "java -jar "+  rails_path + "lib/jars/Pub.jar "
        command_params = "#{image_path} \"#{@problem.comment}\" #{@problem.latitude} #{@problem.longitude} \"#{@problem.user.name}\" #{@problem.user.age} \"#{@problem.user.gender}\" \"#{@problem.user.nationality}\""
        logger.debug ("#{command} #{command_params}")
        system("#{command} #{command_params}")
      end
  end
end
