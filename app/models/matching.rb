class Matching < ActiveRecord::Base
  has_many :participants
  belongs_to :project
  belongs_to :user
  belongs_to :player

 	validates :name, :owner,
	presence: {message: "Please input name."},
	length: {minimum: 2, message: "Please input longer name."},
	length: {maximum: 20, message: "Please input shorter name."}

 	validates :title,
	presence: {message: "Please input title."},
	length: {minimum: 2, message: "Please input longer title."},
	length: {maximum: 20, message: "Please input shorter title."}

 	validates :reguration,
	presence: {message: "Please input reguration."},
	length: {minimum: 2, message: "Please input longer reguration."},
	length: {maximum: 20, message: "Please input shorter reguration."}
	
	# def date_comparison(date, member)
	# 	if date < Time.now
			

	# 	end
	# end
	
end
