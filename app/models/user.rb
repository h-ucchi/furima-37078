class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #全体に空白エラーを表示させる
  #emailとパスワードはdeviseにバリデーション（空欄、パスワードの文字数（6文字））がデフォルトであるので、追記する必要はない
  with_options presence: true do
    validates :nickname

    #名前の漢字入力欄のバリデーション設定
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角のみが使えます" } do
      validates :last_name
      validates :first_name
    end

    validates :birthday

    #名前のカタカナ入力欄のバリデーション設定
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: "カタカナのみが使えます" } do
      validates :last_name_katakana
      validates :first_name_katakana
    end
  end

  #パスワードの半角英数字のバリデーション設定
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "半角英数字のみが使えます" }
  
end
