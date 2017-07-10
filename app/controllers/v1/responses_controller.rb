module V1
  class ResponsesController < ApplicationController
    before_action :set_response, only: [:show, :update, :destroy]
    after_action :send_notification , only: [:create]

    # GET problems/:problem_id/responses
    def index
      @responses = Response.where(problem_id: params[:problem_id])
      if Problem.find(params[:problem_id])
        render json: @responses, each_serializer:
        V1::ResponseSerializer
      end
    end

    # GET /v1/responses/1
    def show
      render json: @response, serializer: V1::ResponseSerializer, root: nil
    end

    # POST /v1/problems/:problem_id/responses
    def create
      @response = Response.new(response_params)
      @response.user = current_user
      @response.problem_id = params[:problem_id]
      if @response.save
        render json: @response, serializer: V1::ResponseSerializer, root: nil,
        status: :created
      else
        render json: @response.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT v1/responses/1
    def update
      if @response.update(response_params)
        render json: @response, serializer: V1::ResponseSerializer, root:nil
      else
        render json: @response.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/responses/1
    def destroy
      @response.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_response
        @response = Response.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def response_params
        params.require(:response).permit(:comment)
      end

      def send_notification
        Thread.new do
          # メールを送る
          # MessageMailer.hello.deliver
          MessageMailer.new_response(@response.problem.user).deliver

          # TODO
          # ここに詳細をかけるようにする
          slack_notify(slack_message)
        end
      end

      def slack_message
        <<-EOC
`新しい返信が投稿されました`
*#{@response.comment}*
>>>
#{@response.problem.comment}

EOC
      end

  end
end
