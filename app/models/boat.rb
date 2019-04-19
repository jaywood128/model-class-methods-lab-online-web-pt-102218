class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five 
    Boat.all.limit(5).map do |b|
      b
    end
   end

   def self.dinghy 
    @dinghies = []
    Boat.all.each do |b|
      if b.length <=20 
        @dinghies << b 
      else 

      end
    end
    @dinghies 
  end

  def self.ship
    Boat.where("length > '20'")
  end 

  def self.last_three_alphabetically
    order(:name).last(3).reverse
  end

  def self.without_a_captain 
    Boat.where(captain: nil)
  end 

  def self.sailboats 
    includes(:classifications).where(classifications: {name: 'Sailboat' } ) 
  end
end