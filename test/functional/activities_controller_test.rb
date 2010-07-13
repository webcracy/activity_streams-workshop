require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Activity.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Activity.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Activity.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to activity_url(assigns(:activity))
  end
  
  def test_edit
    get :edit, :id => Activity.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Activity.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Activity.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Activity.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Activity.first
    assert_redirected_to activity_url(assigns(:activity))
  end
  
  def test_destroy
    activity = Activity.first
    delete :destroy, :id => activity
    assert_redirected_to activities_url
    assert !Activity.exists?(activity.id)
  end
end
