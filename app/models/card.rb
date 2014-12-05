class Card < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :project
  def create(id)
    @card = Card.new
    @card.id = id
    @card.save
  end
end
