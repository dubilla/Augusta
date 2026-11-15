require "rails_helper"

RSpec.describe "Sign in alert", type: :request do
  it "shows the Devise failure message after a failed sign in" do
    user = create(:user)
    post user_session_path, params: { user: { email: user.email, password: "wrong-password" } }
    expect(response.body).to match(%r{<div id="alert"[^>]*>\s*Invalid email or password\.\s*</div>})
  end
end
