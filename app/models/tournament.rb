class Tournament < ActiveRecord::Base
  belongs_to :matching
  has_one :card
  def create(id, param)
    @tournament = Tournament.new
    @tournament.matching_id = id
    @tournament.start = param
    @tournament.is_second_battle = false
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
  
  def first_progress(id)
    @tournament = Tournament.find(id)
    @card = Card.find(id)
    if @tournament.is_second_battle || @card.player_a
      return
    end
    cards = @tournament.cards
    if @card.next
      next_names = @card.next.split(" ")
      p next_names
      next_names.each do |name|
        cards.gsub!(name,"")
      end
    end
    @card.book = delete_name(cards)
    names = @card.book.split(" [")
    @card.save
    names.each do |name|
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
          @card.save
          return
        end
      end
      @card.save
      @tournament.save
    end
    if @card.player_a.nil?
      second_progress(@card.id)
    end
  end  
  
  def second_progress(id)
    @card = Card.find(id)
    @tournament = Tournament.find(id)
    @card.book = nil
    @tournament.is_second_battle = true
    @tournament.save
    if @card.result.nil?
      @card.result = @card.next
      @card.next = nil
    end
    names = @card.result.split(" ")
    if names[1].nil?
      @tournament.result = names[0]
      @tournament.save
      return
    end
    next_battle_name = @card.result
    @card.result = nil
    @card.save
    if @card.player_a.nil?
      @card.player_a = names[0]
      next_battle_name.gsub!(/#{names[0]} /,"")
      @card.player_b = names[1]
      next_battle_name.gsub!(/#{names[1]} /,"")
      next_battle_name.lstrip!
      @card.result = next_battle_name
      @card.save
      if @card.result.empty?
        @card.result = nil
      end
      @card.save
    end
    @card.save
  end
  
  def delete_name(str)
    str.lstrip!
    str.gsub!(/\[\]/,"")
    str.gsub!(/\s*\[, \"\w*\"\]\s*/,"")
    str.gsub!(/\s*\[\"\w*\", \]\s*/,"")
    return str
  end
end
