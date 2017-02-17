require_relative('../db/sql_runner.rb')

class Box_Office
  attr_reader :till
  def initialize
    @till = 0
  end

  def ticket_sale(customer, film)
      cost = film.price
      counter = 0
      if customer.funds >= cost
      customer.funds = customer.funds - cost
      @till = @till + cost
      counter += 1
      ticket = Ticket.new({'customer_id' => customer.id, 'film_id' => film.id}) 
      ticket.save
    else return
      puts "Come back when you can afford it!"
      end
   end

end
