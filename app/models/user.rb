class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #全体に空白エラーを表示させる
  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: true
    
    validates :password, length: { minimum: 6, message: "6文字以上で入力してください" }
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "半角英数字のみが使えます" }
    validates :password, confirmation: true

    validates :last_name
    validates :first_name

    validates :birthday

    #名前のカタカナ入力欄のバリデーション設定
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: "カタカナのみが使えます" } do
      validates :last_name_katakana
      validates :first_name_katakana
    end
  end
end
