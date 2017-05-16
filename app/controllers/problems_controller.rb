class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :update, :destroy]

  # GET /problems
  def index
    @problems = Problem.all
    responce = {"problems" => @problems}
    render json: responce
  end

  # GET /problems/1
  def show
    responce = {"problem" => @problem}
    render json: responce
  end

  # POST /problems
  def create
    @problem = Problem.new(problem_params)

    if @problem.save
      render json: @problem, status: :created, location: @problem
    else
      render json: @problem.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /problems/1
  def update
    if @problem.update(problem_params)
      render json: @problem
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
      params.require(:problem).permit(:comment, :image, :latitude, :longitude, :user_id)
    end
end
