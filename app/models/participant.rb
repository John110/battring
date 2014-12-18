class Participant < ActiveRecord::Base
  belongs_to :matching
  has_and_belongs_to_many :users
  has_and_belongs_to_many :players
  validates :name,
  presence: {message: "を入れてください"},
  length: {minimum: 2, message: "が短すぎます"},
  length: {maximum: 20, message: "が長すぎます"},
  uniqueness: { scope: :matching_id, message: "は既に存在します"}  
end
