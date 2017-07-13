require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    # 自力で書いて見たコード
    # post login_path, params[:session][:email].downcase　
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    # assert_select 'div#error_explanation'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    # assert_not_select 'div#error_explanation'
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user # user_path
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    # ログアウトさせる
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザシュミレート
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    # 自分で考えたテストメモ　assert_equal true ,assigns(:user).cookies.nil?
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

  # test "login layout t" do
  #   get login_path
  #   post login_path, params: { session: {email: "", password: ""} }
  #   assert_select
  #   assert
  #   end
end
