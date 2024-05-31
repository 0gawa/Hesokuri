class Public::UsersController < ApplicationController
    def mypage
        @user = User.find(current_user.id)
        @spends = current_user.spends.all.order(created_at: :desc).limit(5)
        @incomes = current_user.incomes.all.order(created_at: :desc).limit(5)
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
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to mypage_path
        else
            flash.now[:warning]="入力されていない箇所があります"
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:sex, :name, :age, :job, :email, :is_smoker)
    end
end
