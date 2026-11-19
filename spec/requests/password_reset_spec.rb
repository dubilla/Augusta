require "rails_helper"

RSpec.describe "Password reset email", type: :request do
  before { ActionMailer::Base.deliveries.clear }

  it "emails a user a reset link" do
    user = create(:user)
    post user_password_path, params: { user: { email: user.email } }

    expect(ActionMailer::Base.deliveries.size).to eq(1)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq([user.email])
    expect(mail.from.first).to start_with("no-reply@")
    expect(mail.body.encoded).to match(%r{http://www\.example\.com/users/password/edit\?reset_password_token=\S+})
  end

  it "emails an admin a reset link" do
    admin = create(:admin_user)
    post admin_user_password_path, params: { admin_user: { email: admin.email } }

    expect(ActionMailer::Base.deliveries.size).to eq(1)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq([admin.email])
    expect(mail.from.first).to start_with("no-reply@")
    expect(mail.body.encoded).to match(%r{http://www\.example\.com/admin/password/edit\?reset_password_token=\S+})
  end

  it "shows an alert instead of an error page when Mailgun fails" do
    user = create(:user)
    allow_any_instance_of(Mail::Message).to receive(:deliver)
      .and_raise(Mailgun::CommunicationError.new("the server responded with status 403"))

    post user_password_path, params: { user: { email: user.email } }, headers: { "HTTP_REFERER" => new_user_password_url }

    expect(response).to redirect_to(new_user_password_url)
    follow_redirect!
    expect(response.body).to match(%r{<div id="alert"[^>]*>\s*We couldn&#39;t send that email\.})
  end

  it "lets a user set a new password from the emailed link and sign in with it" do
    user = create(:user)
    post user_password_path, params: { user: { email: user.email } }
    token = ActionMailer::Base.deliveries.last.body.encoded[/reset_password_token=([^"&\s]+)/, 1]

    put user_password_path, params: {
      user: { reset_password_token: token, password: "new-password", password_confirmation: "new-password" }
    }

    expect(response).to have_http_status(:redirect)
    expect(user.reload.valid_password?("new-password")).to be true
  end

  it "derives reset tokens from SECRET_KEY_BASE rather than a key committed to the repo" do
    expect(Devise.secret_key).to eq(Rails.application.secret_key_base)
  end
end
