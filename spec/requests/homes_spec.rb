require 'rails_helper'

RSpec.describe "Public::Homes", type: :request do
  describe "homesコントローラーについて" do
    context "ログイン前" do
        it "トップページ" do
            visit root_path
            expect(page.status_code).to eq(200)
        end
    end
  end
end
