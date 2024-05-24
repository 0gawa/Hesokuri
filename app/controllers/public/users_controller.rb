class Public::UsersController < ApplicationController
    def mypage
        @user = User.find(current_user.id)
    end

    def show
    end

    def edit
    end

    def update
    end
end
