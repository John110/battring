class Tournament < ActiveRecord::Base
  belongs_to :matching
  has_one :card
  def create(id, param)
    @tournament = Tournament.new
    @tournament.matching_id = id
    @tournament.start = param
    @tournament.participants = "#{"Azusa"} #{"Lipopo"} #{"Nicola"} #{"Nina"} #{"Luna"}"
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
      @tournament.cards = "#{@tournament.cards}#{hoges} "
    end
    @tournament.save
  end
  
  def first_progress(cards, id)
    @tournament = Tournament.find(id)
    @card = Card.find(id)
    @card.first_battle_time = 0
    names = cards.split(" [")
    names.each do |name|
      p name
      name.delete!("[]")
      if name.include?(",")
        name = name.split(",")
      end
      if name.kind_of?(String)
        if !(@card.next && @card.next.include?("#{name}"))
          @card.next = "#{@card.next}#{name} "
        end
      else
        if @card.player_a.nil?
          @card.player_a = name[0]
          @card.player_b = name[1].delete(" ")
        else
          if @card.book.nil?
            @card.book = "#{@card.book}#{name} "
          end
        end
      end
      @card.save
      @tournament.save
      if !@card.player_a.nil?
        break
      end
    end
  end  
  
  def second_progress(id)
    @card = Card.find(id)
    @tournament = Tournament.find(id)
    if @card.result.nil?
      @card.result = @card.next
      @card.next = nil
    end
    names = @card.result.split(" ")
    if @card.player_a.nil?
      p "delete"
      @card.player_a = names[0]
      @card.result.gsub!(/#{names[0]} /,"")
      @card.player_b = names[1]
      @card.result.gsub!(/#{names[1]} /,"")
      @card.save
    elsif @card.result.nil?
      @tournament.result = names[0]
      @tournament.save
    end 
    @card.save
  end
end
