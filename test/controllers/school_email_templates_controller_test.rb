require 'test_helper'

class SchoolEmailTemplatesControllerTest < ActionController::TestCase
  setup do
    @school_email_template = school_email_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_email_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_email_template" do
    assert_difference('SchoolEmailTemplate.count') do
      post :create, school_email_template: { body: @school_email_template.body }
    end

    assert_redirected_to school_email_template_path(assigns(:school_email_template))
  end

  test "should show school_email_template" do
    get :show, id: @school_email_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school_email_template
    assert_response :success
  end

  test "should update school_email_template" do
    patch :update, id: @school_email_template, school_email_template: { body: @school_email_template.body }
    assert_redirected_to school_email_template_path(assigns(:school_email_template))
  end

  test "should destroy school_email_template" do
    assert_difference('SchoolEmailTemplate.count', -1) do
      delete :destroy, id: @school_email_template
    end

    assert_redirected_to school_email_templates_path
  end
end
