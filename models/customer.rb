require_relative('../db/sql_runner.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING id"
    customer = SqlRunner.run(sql)[0]
    @id = customer['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map{|customer| Customer.new(customer)}
    return result
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    return self.get_many(sql)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def films
    sql = "SELECT films.* FROM films INNER JOIN tickets ON film_id = films.id WHERE customer_id = #{@id};"
    return Film.get_many(sql)
  end

  def tickets
    sql = "SELECT tickets.* FROM tickets WHERE customer_id = #{@id};"
    return Ticket.get_many(sql)
  end

  def buy_ticket(film)
    cost = film.price
    ticket = Ticket.new({'customer_id' => @id, 'film_id' => film.id}) 
    if self.funds >= cost && ticket.ticket_count <= 50
    self.funds -= cost
    self.update
    ticket.save
    elsif self.funds < cost
      return "You could always download it illegally..."
    elsif ticket.ticket_count >= 50
      return "Sold Out!"
    end
  end
end