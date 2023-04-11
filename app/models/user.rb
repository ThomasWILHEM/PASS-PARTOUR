class User < ApplicationRecord
  # Include default devise modules. Others available are:
  has_many :reservations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
