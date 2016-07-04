require 'test_helper'

class ProgressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @progress = progresses(:one)
  end

  test "should get index" do
    get progresses_url
    assert_response :success
  end

  test "should get new" do
    get new_progress_url
    assert_response :success
  end

  test "should create progress" do
    assert_difference('Progress.count') do
      post progresses_url, params: { progress: { amount: @progress.amount, start_date: @progress.start_date } }
    end

    assert_redirected_to progress_url(Progress.last)
  end

  test "should show progress" do
    get progress_url(@progress)
    assert_response :success
  end

  test "should get edit" do
    get edit_progress_url(@progress)
    assert_response :success
  end

  test "should update progress" do
    patch progress_url(@progress), params: { progress: { amount: @progress.amount, start_date: @progress.start_date } }
    assert_redirected_to progress_url(@progress)
  end

  test "should destroy progress" do
    assert_difference('Progress.count', -1) do
      delete progress_url(@progress)
    end

    assert_redirected_to progresses_url
  end
end
