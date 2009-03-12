require 'test_helper'

class <%= controller_class_name %>ControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:<%= table_name %>)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create <%= file_name %>" do
    assert_difference('<%= class_name %>.count') do
      post :new, :<%= file_name %> => { }
    end

    assert_redirected_to  :action => :index
  end


  test "should get edit" do
    get :edit, :id => <%= table_name %>(:one).id
    assert_response :success
  end

  test "should update <%= file_name %>" do
    post :edit, :id => <%= table_name %>(:one).id, :<%= file_name %> => { }
    assert_redirected_to :action => :index
  end

  test "should destroy <%= file_name %>" do
    assert_difference('<%= class_name %>.count', -1) do
      get :destroy, :id => <%= table_name %>(:one).id
    end

    assert_redirected_to :action => :index
  end
end
