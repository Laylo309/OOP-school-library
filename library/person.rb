require_relative './corrector'
require_relative './rental'

#rubocop:disable all
class Person
  attr_reader :id
  attr_accessor :name, :age, :rentals, :parent_permission

  def initialize(age, name = 'Unknown', parent_permission = true)
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @corrector = Corrector.new
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_service?
    age_of? || @parent_permission
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end

  private

  def age_of?
    @age >= 18
  end
end