require 'test_helper'

class AssetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assets" do
    assert_difference('Assets.count') do
      post :create, :assets => { }
    end

    assert_redirected_to assets_path(assigns(:assets))
  end

  test "should show assets" do
    get :show, :id => assets(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assets(:one).id
    assert_response :success
  end

  test "should update assets" do
    put :update, :id => assets(:one).id, :assets => { }
    assert_redirected_to assets_path(assigns(:assets))
  end

  test "should destroy assets" do
    assert_difference('Assets.count', -1) do
      delete :destroy, :id => assets(:one).id
    end

    assert_redirected_to assets_path
  end
end
