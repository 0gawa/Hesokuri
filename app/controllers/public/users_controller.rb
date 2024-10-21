class Public::UsersController < ApplicationController
    def mypage
        @user = User.find(current_user.id)
        @spends = current_user.spends.all.order(created_at: :desc).limit(5)
        @yesterday_money = current_user.incomes.today.sum(:money) - current_user.spends.today.sum(:money)

        @line_chart_data = []
        base_days = [*Date.current - 1.week .. Date.current]
        base_days.each do |base_day|
          day_sum = current_user.spends.where(created_at: base_day.beginning_of_day...base_day.end_of_day).sum(:money)
          @line_chart_data << [base_day.strftime('%Y/%m/%d').to_s, day_sum]
        end

        @week_spends = current_user.spends.this_week
        @week_incomes = current_user.incomes.this_week
        @last_week_spends = current_user.spends.last_week
        @last_week_incomes = current_user.incomes.last_week
        @ratio_spend = @week_spends.sum(:money)*100 / sum_price(@last_week_spends)
        @ratio_income = @week_incomes.sum(:money)*100 / sum_price(@last_week_incomes)

        @incomes = current_user.incomes.all.order(created_at: :desc).limit(5)
        @diff_money=@user.save_money-@user.money
        if @diff_money<0
            @diff_money=0
        end
        month = Time.zone.today
        spend_costs = current_user.spends.where(created_at: month.all_month)  #一度作成された支出レコードは編集できない点に注意
        monthly_cost = spend_costs.sum(:money)
        @spend_ratio = spend_costs.joins(:spend_genre).group("spend_genres.name").sum(:money).sort_by{ |_, v| v }.reverse.to_h
        @spend_ratio.each do |k,v| 
            ratio = (v * 100).to_f / monthly_cost
            @spend_ratio[k] = ratio.round(1)
        end

    end

    def set_money
        @user = User.find(current_user.id)
        @result=0
    end

    # 要修正箇所
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

    # 引数のmoneyカラムの合計を求める
    # 引数のデータ型が不適当または合計値が０の場合は100を返す
    def sum_price(data)    #イテラブルである必要があることに注意
        sum = data.sum(:money)
        if sum.nil? || sum == 0
            sum = 100
        end
    end
end
