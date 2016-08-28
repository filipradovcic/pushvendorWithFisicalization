class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :username, :presence => true, :uniqueness => true


    ROLES = %i[super_admin sale_admin item_admin]




end
