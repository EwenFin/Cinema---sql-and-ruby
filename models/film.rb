require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price, :review

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price']
    @review = options['review']
  end

  def save()
    sql = "INSERT INTO films (title, price, review) VALUES ('#{@title}', #{@price}, '#{@review}') RETURNING id"
    film = SqlRunner.run(sql)[0]
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def  self.get_many(sql)
    films = SqlRunner.run(sql)
    result = films.map{|film|Film.new(film)}
    return result 
  end

  def self.all()
    sql = "SELECT * FROM films"
    return self.get_many(sql)
  end

  def delete
    sql = "DELETE FROM films WHERE id =#{@id};"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE films SET (title, price, review) = ('#{@title}', #{@price}, '#{@review}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customer_id = customers.id WHERE film_id = #{@id};"
    return Customer.get_many(sql)
  end

  def tickets_sold(showing)
    # sql = "SELECT COUNT(id) FROM tickets WHERE tickets.time = showing AND film_id = #{@id}"
    
    #Can you pass an argument to a sql statement?

    sql = "SELECT * FROM tickets WHERE film_id = #{@id}"
    tickets = Ticket.get_many(sql)
    result = tickets.select{|ticket| ticket.time == showing }
    return result.length.to_i
  end

end