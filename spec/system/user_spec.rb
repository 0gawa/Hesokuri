require 'rails_helper'

RSpec.describe "Users", type: :model do
  # describe 'LINEログイン処理' do
  #   before do
  #     Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
  #     Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
  #   end
  #   context 'LINEログインボタンを押した場合' do
  #     it 'ログインができる' do
  #       visit new_user_session_path
  #       click_on  'line_login'
  #       expect(page).to have_content 'マイページ'
  #     end
  #   end
  # end

  describe "ユーザーのバリデーションチェック" do
    context "名前に対して" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      it "nameがnil"  do
        user.name = nil
        expect(user).to be_invalid
      end

      it "名前の文字数"  do
        user.name = "aaaaaaaaaaaaaaaaaaaaaa"
        expect(user).to be_invalid
      end

    end
  end

end