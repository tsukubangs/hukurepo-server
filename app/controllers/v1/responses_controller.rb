module V1
  class ResponsesController < ApplicationController
    before_action :set_response, only: [:show, :update, :destroy]
    before_action :set_problem, only:[:index, :create, :get_seen, :put_seen]

    # GET problems/:problem_id/responses
    def index
      if @problem
        render json: @problem.responses, each_serializer:
        V1::ResponseSerializer
      end
    end

    # POST /v1/problems/:problem_id/responses
    def create
      @response = Response.new_response(response_params, current_user, @problem)

      if @response.save
        render json: @response, serializer: V1::ResponseSerializer, root: nil,
        status: :created
        send_notifications
      else
        render json: @response.errors, status: :unprocessable_entity
      end
    end

    # GET problems/:problem_id/responses/1
    def show_in_problem
      if @problem
        render json: @problem.responses[params[:id]-1], serializer:
        V1::ResponseSerializer
      end
    end

    # GET /v1/problems/1/responses/seen
    def get_seen
      render json: { seen: @problem.responses_seen }
    end

    # PUT /v1/problems/1/responses/seen
    def put_seen
      # 困りごとのオーナーが読んだときのみ、既読とする
      if current_user == @problem.user
        @problem.responses_seen = true
        @problem.save!
        get_seen
      else
        render json: { error: "Only owner of problem can change seen status."}, status: :forbidden
      end
    end

    # GET v1/responses/1
    def show
      render json: @response, serializer: V1::ResponseSerializer, root: nil
    end

    # PATCH/PUT v1/responses/1
    def update
      if @response.update(response_params)
        render json: @response, serializer: V1::ResponseSerializer, root:nil
      else
        render json: @response.errors, status: :unprocessable_entity
      end
    end

    # DELETE v1/responses/1
    def destroy
      if current_user == response.user || current_user == response.problem.user
        @response.destroy
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_response
        @response = Response.find(params[:id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_problem
        @problem = Problem.find(params[:problem_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def response_params
        params.require(:response).permit(:comment)
      end

      def send_notifications
          push_notification(@problem.user, 'You gotta response', @response.comment) if @problem.user != @response.user
          slack_notify(slack_message)
      end

      def slack_message
        <<-EOC
`新しい返信が投稿されました`
From:
  User ID:*#{@response.user.id}*
  Email:*#{@response.user.email}*
  Response:*#{@response.comment}*

>>>
To:
  User ID:*#{@response.problem.user.id}*
  Email:*#{@response.problem.user.email}*
  Problem:*#{@response.problem.comment}*

EOC
      end

  end
end
