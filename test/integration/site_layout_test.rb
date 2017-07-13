require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test"layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    # get signup_path
    assert_select "a[href=?]", signup_path
    get contact_path
    assert_select "title", full_title("Contact")
  end

  def setup
    @user = users(:michael)
  end

  test "layout links when logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_path
    # assert_select "a[href=?]", users_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    # 自分で書いてみたメモ
    # assert_select "a[href=?]", root_path, count: 2
    # assert_select "a[href=?]", help_path
    # assert_select "a[href=?]", about_path
    # assert_select "a[href=?]", contact_path
    # assert_select "a[href=?]", logout_path
    # assert_select "a[href=?]", signup_path
  end
end
