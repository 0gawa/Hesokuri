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
        current_user.money-@spend.money<0 && return 

        @spend.money-=current_user.money
        if @spend.save!
            redirect_to spends_path
        else
            flash.now[:warning]="支出額は必ず入力してください"
            render :new
        end
    end

    def index
        @spends=current_user.spends.all
    end

    private

    def spend_params
        params.require(:spend).permit(:money, :comment, :spend_genre_id)
    end
end
