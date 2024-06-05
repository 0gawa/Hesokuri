class Public::SpendsController < ApplicationController
    def new
        @spend=Spend.new
    end

    def create
        @spend=Spend.new(spend_params)
        @spend.user_id=current_user.id
        if @spend.comment.blank?
            @spend.comment="No Comment" #ここでデフォルトコメントを修正できる
        end
        is_ok=true
        if @spend.money.nil?
            flash.now[:warning]="支出額を入力してください"
            is_ok=false
        elsif current_user.money-@spend.money<0
            flash.now[:warning]="支出額が貯金額を超えています"
            is_ok=false
        else
            current_user.money-=@spend.money
        end

        if is_ok && @spend.save
            current_user.save
            redirect_to spends_path
        else
            flash.now[:warning]="支出額は必ず入力してください"
            render :new
        end
    end

    def index
        @spends = current_user.spends.all.order(created_at: :desc)
    end

    private

    def spend_params
        params.require(:spend).permit(:money, :comment, :spend_genre_id)
    end
end
