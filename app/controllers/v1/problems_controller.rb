module V1
  class ProblemsController < ApplicationController
    include Orderable

    before_action :set_problem, only: [:show, :update, :destroy]

    # afterの順番大事 translate -> push_notificationsの順番
    after_action :auto_response, only: [:create]
    after_action :push_notifications, only: [:create]
    after_action :translate_japanese_comment, only: [:create]


    has_scope :responded, :type => :boolean, allow_blank: true
    has_scope :seen, :type => :boolean, allow_blank: true
    has_scope :by_response_priority

    # GET /v1/problems
    def index
      @problems = apply_scopes(Problem).all
      order_problems
      paginate_problems

      render json: @problems, each_serializer: V1::ProblemSerializer
    end

    # POST /v1/problems
    def create
      @problem = Problem.new_problem(problem_params, current_user)

      if @problem.save
        render json: @problem, serializer: V1::ProblemSerializer, root: nil,
               status: :created, location: v1_problem_url(@problem)
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
      @problems = apply_scopes(Problem).where(user_id: params[:user_id])
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
      @problems = current_user.responded_problems
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
        params.require(:problem).permit(:comment, :image, :latitude, :longitude, :response_priority)
      end

      def paginate_problems
        @problems = @problems.page(params[:page]).per(params[:per] ||= 5) if params[:page]
      end

      def order_problems
        @problems = @problems.order(ordering_params(params)).order(updated_at: :desc)
      end

      def translate_japanese_comment
        return if @problem.japanese_comment.present?
        begin
          @problem.japanese_comment = translate(@problem.comment, :to => :japanese)
          @problem.save
        rescue
          # 処理を中断しないため、例外をキャッチ
        end
      end

      def push_notifications
        return unless @problem.is_response_necessary?

        to_users = User.where(role: 'respondent')
        to_users.each do |to_user|
          push_notification(to_user, '新しい困りごとが投稿されました', @problem.japanese_comment)
        end
      end

      def auto_response
        return if @problem.is_response_necessary?
        @problem.create_auto_response
      end
  end
end
