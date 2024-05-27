class Public::IncomesController < ApplicationController
    def new
        @income=Income.new
    end

    def index
        @incomes=current_user.incomes.all
    end

    def create
        @income=Income.new(spend_params)
        @income.user_id=current_user.id
        if @income.comment.blank?
            @income.comment="No Comment" #ここでデフォルトコメントを修正できる
        end
        if @income.save
            current_user.money+=@income.money
            redirect_to incomes_path
        else
            if !@income.money.blank? && @income.money<0
                flash.now[:warning]="収入額が適当ではありません"
            else
                flash.now[:warning]="収入額は必ず入力してください"
            end
            render :new
        end
    end

    private

    def spend_params
        params.require(:income).permit(:money, :comment)
    end
end
