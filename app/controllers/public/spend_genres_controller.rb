class Public::SpendGenresController < ApplicationController
    def new
        @genre=SpendGenre.new
        @genres=current_user.spend_genres.all
    end

    def index
        @genres=current_user.spend_genres.all
    end

    def create
        @genre=SpendGenre.new(spend_genre_params)
        @genre.user_id=current_user.id
        cnt=current_user.spend_genres.all
        if cnt.count<=10 and @genre.save
            redirect_to spend_genres_path
        else
            @genres=SpendGenre.all
            if cnt.count > 14
                flash.now[:warning]="これ以上ジャンルを追加することはできません。"
            else
                flash.now[:warning]="ジャンル名を入力してください"
            end
            render :new
        end
    end

    def edit
        @genre=SpendGenre.find(params[:id])
    end

    def update
    end

    def destroy
        genre=SpendGenre.find(params[:id]).destroy
        redirect_to spend_genres_path
    end

    private

    def spend_genre_params
        params.require(:spend_genre).permit(:name)
    end
end
