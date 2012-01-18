require 'test_helper'

class AbstractsControllerTest < ActionController::TestCase
  setup do
    @abstract = abstracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abstracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abstract" do
    assert_difference('Abstract.count') do
      post :create, :abstract => @abstract.attributes
    end

    assert_redirected_to abstract_path(assigns(:abstract))
  end

  test "should show abstract" do
    get :show, :id => @abstract.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @abstract.to_param
    assert_response :success
  end

  test "should update abstract" do
    put :update, :id => @abstract.to_param, :abstract => @abstract.attributes
    assert_redirected_to abstract_path(assigns(:abstract))
  end

  test "should destroy abstract" do
    assert_difference('Abstract.count', -1) do
      delete :destroy, :id => @abstract.to_param
    end

    assert_redirected_to abstracts_path
  end
end
