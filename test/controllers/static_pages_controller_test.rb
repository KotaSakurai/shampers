require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  # test "should get root" do
  # get root_url
  #  assert_response :success
  # end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should search user" do
    log_in_as (@user)
    get search_path
    assert_response :success
    get search_users_path, params: { search_users: "a" }, xhr: true
    assert_match @other_user.name, response.body
  end

  test "should can not search no word" do
    log_in_as (@user)
    get search_path
    assert_response :success
    get search_users_path, params: { search_users: "" }, xhr: true
    assert_match 'error', response.body
  end

  test "should search not existing user" do
    log_in_as (@user)
    get search_path
    assert_response :success
    get search_users_path, params: { search_users: "aaaa" }, xhr: true
    search_user = assigns(:search_users)
    assert_equal search_user.count, 0
  end
end
