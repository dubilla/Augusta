class User < ApplicationRecord

  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :team, inverse_of: :user

  def name
    [first_name, last_name].join(" ")
  end

end
