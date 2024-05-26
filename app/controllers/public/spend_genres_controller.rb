class Public::SpendGenresController < ApplicationController
    def new
        @genre=SpendGenre.new
        @genres=SpendGenre.all
    end

    def index
        @genres=SpendGenre.all
    end

    def create
        @genre=SpendGenre.new(spend_genre_params)
        @genre.user_id=current_user.id
        if @genre.save!
            redirect_to spend_genres_path
        else
            flash.now[:warning]="ジャンル名を入力してください"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @genre=SpendGenre.find(params[:id])
    end

    def update
    end

    def destroy
    end

    private

    def spend_genre_params
        params.require(:spend_genre).permit(:name)
    end
end
