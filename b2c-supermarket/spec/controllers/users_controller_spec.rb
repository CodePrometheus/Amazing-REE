require 'rails_helper'

describe UsersController do
  context "Sign In" do
    it "should failed" do
      post :create, params: { user: { email: "codeprince2020@163.com" } }
      expect(response).to render_template("new")
    end
    it "should success" do
      post :create, params: { user: {
          email: "codeprince2020@163.com",
          password: "123456",
          password_confirmation: "123456"
        }
      }
      expect(response).to redirect_to(new_session_path)
    end
  end
end