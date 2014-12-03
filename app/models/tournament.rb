class Tournament < ActiveRecord::Base
  belongs_to :matching
  def create(id, param)
    @tournament = Tournament.new
    @tournament.matching_id = id
    @tournament.start = param
    @tournament.save
  end
  
  def update(participant, id)
    @tournament = Tournament.find(id)
    @tournament.participants = "#{@tournament.participants}#{participant} "
    @tournament.save
  end
  
  def setting(participants, id)
    @tournament = Tournament.find(id)
    members = participants.split(" ")
    numbers = [members.size]
    while !numbers.flatten.include?(0) do
      numbers.flatten.each_with_index do |number, index|
        numbers[index] = [number / 2, number - number / 2]
      end
    end
    
    numbers.each do |pair|
      hoges = []
      pair.each do |volume|
        if volume == 1
          hoge = members.sample(1).join
          hoges << hoge
          members.delete(hoge)
        end
      end
      # p hoge
      @tournament.cards = "#{@tournament.cards}#{hoges} "
    end
    @tournament.save
  end
  
  def progress(cards, id)
    @tournament = Tournament.find(id)
    hoge = cards.split(" [")
    hoge.each do |name|
      name.delete!("[]")
      if name.include?(",")
        name = name.split(",")
        
      end
      @tournament.card = name
      @tournament.save
    end
  end
end
