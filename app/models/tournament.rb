class Tournament < ActiveRecord::Base
  belongs_to :matching
  def create(id, param)
    @tournament = Tournament.new
    @tournament.matching_id = id
    @tournament.start = Time.parse("#{param["start(1i)"]}-#{param["start(2i)"]}-#{param["start(3i)"]} #{param["start(4i)"]}:#{param["start(5i)"]}").to_datetime
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
    seeds = []
    @tournament.save
  end
end
