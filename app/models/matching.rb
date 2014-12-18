class Matching < ActiveRecord::Base
  has_many :participants
  belongs_to :project
  belongs_to :user
  belongs_to :player
  has_one :tournament
  has_one :card

 	validates :name,
	presence: {message: "を入れてください"},
	length: {minimum: 2, message: "が短すぎます"},
	length: {maximum: 20, message: "が長すぎます"}

 	validates :reguration,
	presence: {message: "を入れてください"},
	length: {minimum: 2, message: "が短すぎます"},
	length: {maximum: 20, message: "が長すぎます"}	
end
