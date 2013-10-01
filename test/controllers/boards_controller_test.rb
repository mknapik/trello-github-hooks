require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  setup do
    @board = boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create board" do
    assert_difference('Board.count') do
      post :create, board: { name: @board.name, repository_id: @board.repository_id, uid: @board.uid }
    end

    assert_redirected_to board_path(assigns(:board))
  end

  test "should show board" do
    get :show, id: @board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @board
    assert_response :success
  end

  test "should update board" do
    patch :update, id: @board, board: { name: @board.name, repository_id: @board.repository_id, uid: @board.uid }
    assert_redirected_to board_path(assigns(:board))
  end

  test "should destroy board" do
    assert_difference('Board.count', -1) do
      delete :destroy, id: @board
    end

    assert_redirected_to boards_path
  end
end
