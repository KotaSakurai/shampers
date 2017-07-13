require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    # ユーザeditパスへ。レイアウトの表示。送信、レイアウトの表示。
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "foo@valid", password: "foo", password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 4 errors."
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "KuRO"
    email = "gg@gg.com"
    patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user) || default
    name = "Foo bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
