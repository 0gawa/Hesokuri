class Public::UsersController < ApplicationController
    def mypage
        @user = User.find(current_user.id)
    end

    def set_money
        @user = User.find(current_user.id)
    end

    def create_money
        
    end

    def show
    end

    def edit
        @user=User.find(current_user.id)
    end

    def update
    end
end
