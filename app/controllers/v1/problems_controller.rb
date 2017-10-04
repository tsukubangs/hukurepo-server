module V1
  class ProblemsController < ApplicationController
    include Orderable

    before_action :set_problem, only: [:show, :update, :destroy]
    after_action :translate_japanese_comment, only: [:create]

    has_scope :responded, :type => :boolean, allow_blank: true

    # GET /v1/problems
    def index
      @problems = apply_scopes(Problem).all
      order_problems
      paginate_problems


      render json: @problems, each_serializer: V1::ProblemSerializer
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
      else
        render json: @problem.errors, status: :unprocessable_entity
      end
    end

    # GET /v1/problems/1
    def show
      render json: @problem, serializer: V1::ProblemSerializer
    end

    # GET /v1/users/1/problems
    def users
      @problems = Problem.where(user_id: params[:user_id])
      order_problems
      paginate_problems

      render json: @problems, each_serializer: V1::ProblemSerializer
    end

    # GET /v1/problems/me
    # GET /v1/users/me/problems
    def me
      params[:user_id] = current_user.id
      users
    end

    # GET /v1/problems/me/count
    # GET /v1/users/me/problems/count
    def me_count
      count = Problem.where(user_id: current_user.id).count
      render json: { count: count }
    end

    # GET /v1/problems/responded
    def responded
      problem_ids = Response.where(user_id: current_user.id).select(:problem_id)
      @problems = Problem.where(id: problem_ids)
      order_problems
      paginate_problems
      render json: @problems, each_serializer: V1::ProblemSerializer
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
      if current_user == @problem.user
        @problem.destroy
      else
        render json: nil, status: :forbidden
      end
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

      def paginate_problems
        @problems = @problems.page(params[:page]).per(params[:per] ||= 5) if params[:page]
      end

      def order_problems
        @problems = @problems.order(ordering_params(params)).order(updated_at: :desc)
      end

      def translate_japanese_comment
        begin
          @problem.japanese_comment = translate(@problem.comment, :to => :japanese)
          @problem.save
        rescue
          # 例外のときは何もしない
        end
      end

      def slack_message
        <<-EOC
`新しい困りごとが投稿されました`
User ID:*#{@problem.user.id}*
Email:*#{@problem.user.email}*
Problem:*#{@problem.comment}*

EOC
      end
  end
end
