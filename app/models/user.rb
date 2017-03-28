# User describes persistence logic and relations of users
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :timeoutable, :rememberable, :trackable, :validatable

  has_many :tasks, dependent: :destroy
end
