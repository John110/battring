class Participant < ActiveRecord::Base
  belongs_to :matching
  has_and_belongs_to_many :users
  has_and_belongs_to_many :players
  	validates :name,
	presence: {message: "Please input name."},
	length: {minimum: 2, message: "Please input longer name."},
	length: {maximum: 20, message: "Please input shorter name."}
  
end
