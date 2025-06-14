class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :event_participants
  has_many :events, through: :event_participants
  has_one  :store

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
