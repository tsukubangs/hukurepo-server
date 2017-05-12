require 'test_helper'

class ProblemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @problem = problems(:one)
  end

  test "should get index" do
    get problems_url, as: :json
    assert_response :success
  end

  test "should create problem" do
    assert_difference('Problem.count') do
      post problems_url, params: { problem: { comment: @problem.comment, image: @problem.image, latitude: @problem.latitude, longitude: @problem.longitude, user_id: @problem.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show problem" do
    get problem_url(@problem), as: :json
    assert_response :success
  end

  test "should update problem" do
    patch problem_url(@problem), params: { problem: { comment: @problem.comment, image: @problem.image, latitude: @problem.latitude, longitude: @problem.longitude, user_id: @problem.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy problem" do
    assert_difference('Problem.count', -1) do
      delete problem_url(@problem), as: :json
    end

    assert_response 204
  end
end
