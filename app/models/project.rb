class Project < ActiveRecord::Base
	has_many :tasks
	has_many :favorites
	validates :title,
	presence: { message: "入力してください" },
	length: { maximum: 30, message: "長過ぎます" }
end
