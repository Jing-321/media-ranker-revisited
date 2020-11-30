require "test_helper"

describe UsersController do

  describe "auth_callback" do
    it "log in an existing user and redirect to homepage" do
      start_count = User.count
      user = users(:ada)
      perform_login(user)
      must_redirect_to root_path
      session[:user_id].must_equal user.id
      User.count.must_equal start_count
    end

    it "create a new user account and redirect to root path" do
      start_count = User.count
      user = User.new(provider:'github', uid:423123, email: 'a@ada.com', username: "Max")
      perform_login(user)
      must_redirect_to root_path
      user = User.find_by(uid: user.uid)
      session[:user_id].must_equal user.id
      User.count.must_equal start_count + 1
    end

    it "redirect to root path if given invalid info" do

    end
  end

end
