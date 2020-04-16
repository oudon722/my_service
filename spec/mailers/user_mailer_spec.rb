require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include ResetSupport
  reset_token = User.new_token
  # describe "account_activation" do
  #   user = FactoryBot.build(:user)
  #   let(:mail) { UserMailer.account_activation(user) }
  #
  #   it "renders the headers" do
  #     expect(mail.subject).to eq("[スマ宅] アカウント有効化")
  #     expect(mail.to).to eq(["#{user.email}"])
  #     expect(mail.from).to eq(["noreplym@example.com"])
  #   end
  #
  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("#{@user.name}さん。")
  #   end
  # end

  describe "password_reset" do
    let(:user) { FactoryBot.create(:user, reset_digest: digest(reset_token), reset_token: reset_token)}
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("[スマ宅]パスワード再設定")
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["noreply@example.com"]
    end

    # it "renders the body" do
    #   expect(mail.body).to match("#{user.name}さん、")
    # end
  end

end
