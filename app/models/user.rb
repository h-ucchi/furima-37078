class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :encrypted_password, length: { minimum: 6 }
  
  validates :encrypted_password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
  validates :encrypted_password, confirmation: true
end
