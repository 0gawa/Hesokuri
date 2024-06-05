class Public::UsersController < ApplicationController
    def mypage
        @user = User.find(current_user.id)
        @spends = current_user.spends.all.order(created_at: :desc).limit(5)
        @incomes = current_user.incomes.all.order(created_at: :desc).limit(5)
        @diff_money=@user.save_money-@user.money
        if @diff_money<0
            @diff_money=0
        end
    end

    def set_money
        @user = User.find(current_user.id)
        @result=0
    end

    def create_money
        if params[:user][:income].nil? || params[:user][:bonus].nil?
            flash.now[:warning]="収入額とボーナスは必ず入力してください"
            @result=0
        else
            user=User.find(current_user.id)
            if user.age < 30
                standard = params[:user][:income].to_i*0.15
                b_rate=0.4
            else
                standard = params[:user][:income].to_i*0.20
                b_rate=0.5
            end
            if params[:user][:degree].to_i==2 && user.is_smoker && !params[:user][:smoke].nil?
                standard+=(params[:user][:smoke].to_i*0.3 + params[:user][:income].to_i*0.1)
                b_rate=0.55
            elsif params[:user][:degree].to_i==2
                standard+=params[:user][:income].to_i*0.1
                b_rate=0.55
            elsif params[:user][:degree].to_i==0
                standard-=params[:user][:income].to_i*0.05
            end
            case params[:user][:time].to_i
            when 0; date=1; b_cnt=0
            when 1; date=3; b_cnt=0
            when 2; date=6; b_cnt=1
            when 3; date=12; b_cnt=2
            when 4; date=36; b_cnt=6
            when 5; date=60; b_cnt=10
            else
                puts"Error"
            end
           @result=standard*date+params[:user][:bonus].to_i*b_rate*b_cnt
        end
        @user = User.find(current_user.id)
    end

    def set_save_money
        @user=User.find(current_user.id)
        if params[:user][:save_money].to_i!=0 && @user.update(save_money_params)
            redirect_to mypage_path
        else
            flash.now[:warning]="目標金額は1円以上である必要があります"
            render :set_money, status: :unprocessable_entity
        end
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

    def unsubscribed
    end

    def withdrawal
        user = User.find(current_user.id)
        user.update(is_unsubscribed: true)
        reset_session
        flash[:notice] = "退会しました。"
        redirect_to root_path
    end

    private

    def user_params
        params.require(:user).permit(:sex, :name, :age, :job, :email, :is_smoker)
    end
    def save_money_params
        params.require(:user).permit(:save_money)
    end
end
