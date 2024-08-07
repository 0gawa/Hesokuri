# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
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
    if current_user.nil? || current_user.spend_genres.count >=7
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

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :sex, :job, :age, :is_smoker])
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

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  def after_sign_up_path_for(resource)
    mypage_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
