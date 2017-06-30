module V1
  class ResponsesController < ApplicationController
    before_action :set_response, only: [:show, :update, :destroy]

    # GET problems/:problem_id/responses
    def index
      @responses = Response.where(problem_id: params[:problem_id])
      render json: @responses, each_serializer:
      V1::ResponseSerializer
    end

    # GET /v1/responses/1
    def show
      render json: @response, serializer: V1::ResponseSerializer, root: nil
    end

    # POST /v1/responses
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
  end
end
