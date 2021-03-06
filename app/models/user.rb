class User < ActiveRecord::Base
  has_many :favorites
  has_many :projects, through: :favorites
  has_many :matchings
  belongs_to :player
end
