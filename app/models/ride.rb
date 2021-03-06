class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    #binding.pry
    if too_short && not_enough_tickets
      response = "Sorry. " + tickets_message + " " + height_message
    elsif
      not_enough_tickets
      response = "Sorry. " + tickets_message
    elsif
      too_short
      response = "Sorry. " + height_message
    else
      go_on_ride
      response = "Thanks for riding the #{self.attraction.name}!"
    end
  end

  def not_enough_tickets
    self.user.tickets < self.attraction.tickets
  end

  def tickets_message
    "You do not have enough tickets to ride the #{self.attraction.name}."
  end

  def too_short
    self.user.height < self.attraction.min_height
  end

  def height_message
    "You are not tall enough to ride the #{self.attraction.name}."
  end

  def go_on_ride
    user.tickets = user.tickets - attraction.tickets
    user.nausea = user.nausea + attraction.nausea_rating
    user.happiness = user.happiness + attraction.happiness_rating
    user.save
  end


end
