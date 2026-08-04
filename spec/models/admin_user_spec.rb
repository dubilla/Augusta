require 'rails_helper'

# AdminUser is a Devise :validatable model — these examples pin the validation
# behavior that upgrade churn (Devise/Rails bumps, config changes) could silently
# alter. Password floor is 8 per config/initializers/devise.rb (password_length),
# email uniqueness is case-insensitive (case_insensitive_keys).
RSpec.describe AdminUser, type: :model do
  it "is valid with an email and password" do
    expect(build(:admin_user)).to be_valid
  end

  describe "email" do
    it "is required" do
      admin = build(:admin_user, email: "")
      expect(admin).not_to be_valid
      expect(admin.errors[:email]).to include("can't be blank")
    end

    it "must be unique" do
      create(:admin_user, email: "taken@test.com")
      expect(build(:admin_user, email: "taken@test.com")).not_to be_valid
    end

    it "is unique case-insensitively" do
      create(:admin_user, email: "Taken@test.com")
      expect(build(:admin_user, email: "taken@test.com")).not_to be_valid
    end

    it "rejects a malformed address" do
      expect(build(:admin_user, email: "not-an-email")).not_to be_valid
    end
  end

  describe "password" do
    it "is required" do
      admin = build(:admin_user, password: nil)
      expect(admin).not_to be_valid
      expect(admin.errors[:password]).to include("can't be blank")
    end

    it "must be at least 8 characters" do
      expect(build(:admin_user, password: "short12")).not_to be_valid   # 7 chars
      expect(build(:admin_user, password: "longenough")).to be_valid
    end
  end
end
