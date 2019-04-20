class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: 'Catamaran' } ) 
  end 

  def self.sailors 
    self.includes(boats: :classifications).where(classifications: {name: 'Sailboat' } ).distinct
  end

  def self.talented_seafarers 
    self.where("id IN (?)", self.sailors.ids & self.motorboaters.ids) 
  end 

  def self.motorboaters
    self.includes(boats: :classifications).where(classifications: {name: 'Motorboat' } ).distinct
  end 

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end

