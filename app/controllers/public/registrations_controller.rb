class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, :is_correct_user, only: [:create]
  after_action :create_spendGenre, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  #新規登録後、支出項目を自動作成
  def create_spendGenre
    @limit_number = 7
    if current_user.nil? || current_user.spend_genres.count >= @limit_number
      return 
    else
      SpendGenre.create!([
        {name: "食費", user_id: current_user.id},
        {name: "電気代", user_id: current_user.id},
        {name: "水道料金", user_id: current_user.id},
        {name: "ガス代", user_id: current_user.id},
        {name: "家賃", user_id: current_user.id},
        {name: "保険医療費", user_id: current_user.id},
        {name: "その他", user_id: current_user.id}
      ])
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def is_correct_user
    if self.is_filled_form
      user = User.find_by(email: params[:user][:email])
      if user.present?
        flash[:notice] = "そのアカウントはすでに存在しています" and return
      end
      if params[:user][:password].length>=6 && params[:user][:password].length <= 128
        if params[:user][:password] === params[:user][:password_confirmation]
          #名前の確認へ進む
        else
          flash[:notice] = "確認用と一致しません" and return
        end
      else
        flash[:notice] = "パスワードは6文字以上128文字以下である必要があります。" and return
      end
    else
      flash[:notice] = "すべてに入力する必要があります" and return
    end

    #追加のパラメーター(devise非搭載)に関するflashメッセージ
    if !valid_name?(params[:user][:kan_name])
      flash[:notice] = "名前は2文字以上20字以下にする必要があります" and return
    end
  end

  def valid_name?(name)
    name.length >= 2 && name.length <= 20
  end


  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :kan_name, :kana_name, :sex, :job, :age, :is_smoker,
                                      :prefecture, :region, :phone_number])
  end

  def user_state
    ## 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:user][:password]) && @customer.is_unsubscribed
      redirect_to new_user_registration_path 
    end
  end

  def after_sign_up_path_for(resource)
    mypage_path
  end

  def is_filled_form
    is_ok = true
    if !(params[:user][:email].present? && params[:user][:kan_name].present? && params[:user][:password].present? && params[:user][:password_confirmation].present?)
      is_ok = false
    end
    if !(params[:user][:sex].present? && params[:user][:job].present? && params[:user][:age].present? && params[:user][:is_smoker].present?)
      is_ok = false
    end
    return is_ok
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
