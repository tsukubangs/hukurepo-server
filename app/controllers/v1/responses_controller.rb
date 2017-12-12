module V1
  class ResponsesController < ApplicationController
    include Orderable

    before_action :set_response, only: [:show, :update, :destroy]
    before_action :set_problem, only: [:index, :create, :get_seen, :put_seen]

    # afterの順番大事 translate -> push_notificationsの順番
    after_action :push_notifications, only: [:create]
    after_action :translate_japanese_comment, only: [:create]

    # GET problems/:problem_id/responses
    def index
      if @problem
        render json: Response.where(problem_id: @problem.id).order(ordering_params(params)), each_serializer:
        V1::ResponseSerializer
      end
    end

    # POST /v1/problems/:problem_id/responses
    def create
      @response = Response.new_response(response_params, current_user, @problem)

      if @response.save
        render json: @response, serializer: V1::ResponseSerializer, root: nil,
        status: :created
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
      if current_user == @response.user || current_user == @response.problem.user
        @response.destroy
      else
        render json: nil, status: :forbidden
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
        params.require(:response).permit(:comment, :japanese_comment)
      end

      def translate_japanese_comment
        # japanese_commentが空のとき、commentから日本語に翻訳する
        # (commentは英語が入っていることを想定)
        return if @response.japanese_comment.present?
        begin
          @response.japanese_comment = translate(@response.comment, :to => :japanese)
          @response.save
        rescue
          # 処理を中断しないため、例外をキャッチ
        end
      end

      def push_notifications
        # 投稿者が返信したときには、困りごとに返信したことがある回答者にプッシュ通知が送られる
        # 回答者が返信したときには、困りごとの投稿者にプッシュ通知が送られる
        if @problem.user == @response.user
          response_users.each do |to_user|
            push_notification(to_user, "困りごと投稿者からコメントがきました", @response.japanese_comment)
          end
        else
          # 投稿者にプッシュ通知（投稿者自身が返信したときを除く）
          push_notification(@problem.user, "You've got a response", @response.comment)
        end
      end

      def response_users
        # 返信したことがある者にプッシュ通知(回答者自身にはプッシュ通知を送らない 投稿者は回答者として扱わない）
        not_ids =  [@response.user.id, @problem.user.id]
        return @problem.responded_users.where.not(id: not_ids).to_a
      end
  end
end
