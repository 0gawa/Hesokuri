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

  describe "バリデーションチェック" do
    
  end
end