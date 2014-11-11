class User < ActiveRecord::Base
	has_many :favorites
	has_many :projects, through: :favorites
	validate :true,
	presence: { message: "入力してください" }
end
